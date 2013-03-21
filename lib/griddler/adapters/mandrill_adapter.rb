module Griddler
  module Adapters
    class MandrillAdapter
      def initialize(params)
        @params = JSON.parse(params[:mandrill_events]).map(&:with_indifferent_access)
      end

      def self.normalize_params(params)
        adapter = new(params)
        adapter.normalize_params
      end

      def normalize_params
        @params.map do |param|
          {
            to: param[:msg][:email],
            from: param[:msg][:from],
            subject: param[:msg][:subject],
            text: param[:msg][:text],
            html: param[:msg][:html],
            attachments: attachment_files
          }
        end
      end

      private

      attr_reader :params

      def attachment_files
      end
    end
  end
end
