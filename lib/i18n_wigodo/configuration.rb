module I18nWigodo
  class Configuration
    attr_accessor :document_id
    attr_accessor :document_url

    def initialize
      id_from_credentials = Rails.application.credentials.wigodo_doc_id
      id_from_secrets = Rails.application.respond_to?(:secrets) ? Rails.application.secrets.wigodo_doc_id : nil
      @document_id = id_from_credentials || id_from_secrets
    end

    def get_document_id
      if @document_url
        if @document_url =~ /^https:\/\/docs\.google\.com\/spreadsheets\/d\//
          @document_url.split('/')[5]
        else
          raise "Wigodo: document_url has an unexpected format #{@document_url}. It might help to update the gem (i18n-wigodo)."
        end
      else
        if @document_id.present?
          @document_id
        else
          nil
        end
      end
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
