require 'net/http'
require 'uri'
require 'csv'

def fetch_with_redirect(uri_str, limit = 10)
  raise ArgumentError, 'HTTP redirect too deep' if limit == 0

  url = URI.parse(uri_str)
  response = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.get(url.path + (url.query ? "?#{url.query}" : "")) }
  case response
  when Net::HTTPRedirection then fetch_with_redirect(response['location'], limit - 1)
  when Net::HTTPSuccess     then response
  else
    response.error!
  end
end

namespace :wigodo do
  desc 'Import translations from Google Drive'
  task :fetch do
    document_id = Rails.application.secrets.wigodo_doc_id || Rails.application.credentials.wigodo_doc_id

    unless document_id
      abort("i18n-wigodo: wigodo_doc_id not set!\n" +
            "Add the id of your Google Doc spreadsheet to\n" +
            "config/credentials.yml (Rails < 5.2: config/secrets.yml).\n" +
            "Use wigodo_doc_id as key.\n\n" +
            "Example:\n\n" +
            "wigodo_doc_id: 1en5BoKGaAqO9_BRSQ9CQKkvwrYQWNBUPjgSzxyn83Pc\n\n" +
            "(This is the id of a sample document your can check out here:\n" +
            "https://docs.google.com/spreadsheets/d/1en5BoKGaAqO9_BRSQ9CQKkvwrYQWNBUPjgSzxyn83Pc/edit#gid=0")
    end

    resp = fetch_with_redirect("https://docs.google.com/spreadsheets/d/#{document_id}/export?format=csv")

    # puts resp.body.force_encoding('UTF-8')
    rows = CSV.parse(resp.body.force_encoding('UTF-8'))
    locales = rows.first[2..-1]
    default_locale_index = 2

    hash = {}
    locales.each do |locale|
      locale_index = locales.find_index(locale) + 2
      hash[locale] = {}
      rows[1..-1].each do |cols|
        if cols.first.present?
          last_item = hash[locale]
          keys = cols.first.split('.')
          keys[0..-2].each do |key|
            last_item = last_item[key] ||= {}
          end
          content = cols[locale_index]
          default_content = cols[default_locale_index]
          last_item[keys[-1]] = content.present? ? content : default_content
        end
      end

      filename = "#{Rails.root}/config/locales/remote.#{locale}.yml"
      print "generating #{filename}..."
      File.open(filename, "w") do |f|
        f.write({locale => hash[locale]}.to_yaml)
      end
      puts "OK"
    end
  end

  desc 'Output a CSV style file with existing translations (to be imported into Google Spreadsheets)'
  task export: :environment do
    require 'yaml'
    #I18n.locale = :en
    de_input = YAML.load(IO.readlines('config/locales/de.yml').join("\n"))
    input = YAML.load(IO.readlines('config/locales/en.yml').join("\n"))
    def make_hash_one_dimensional(input = {}, output = {}, options = {})
      input.each do |key, value|
        key = options[:prefix].nil? ? "#{key}" : "#{options[:prefix]}.#{key}"
        if value.is_a? Hash
          make_hash_one_dimensional(value, output, :prefix => key)
        else
          output[key]  = value
        end
      end
      output
    end

    output = {}
    make_hash_one_dimensional(input, output)

    output_de = {}
    make_hash_one_dimensional(de_input, output_de)
    output_de = output_de.sort.to_h

    output.sort.to_h.each do |k, v|
      v = v.tr("\n", ' ')
      wol = "de." + k[3..-1]
      de = output_de[wol] ? "\t" + output_de[wol] : nil
      puts "#{k}\t#{v}#{de}"
    end
  end
end
