module Gnoibox
  class Inquiry < ActiveRecord::Base
    include ColumnHoldable

    self.table_name= :gnoibox_inquiries

    EMAIL_VALIDATION = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    scope :recent, ->{ order(created_at: :desc) }

    delegate :notice_mail_subject, :notice_mail_view, :thanks_mail_subject, :thanks_mail_view, to: :form
    
    def set_content
      # set_tags_from_content
      write_attribute :content, content.to_json
      super
    end

    def form
      self.class.form
    end

    def update(args)
      assign_attributes(args)
      save
      self
    end
    
    def valid?(context=nil)
      return false unless content.valid?(context)
      super
    end

    def save_and_notify(url_parser)
      save.tap do |result|
        if result
          Gnoibox::InquiryMailer.notice(self, url_parser).deliver
          Gnoibox::InquiryMailer.thank_if_possible(self, url_parser).deliver
        end
      end
    end
    
    def inquirer_email
      cols.detect{|col| col.settings[:belongs_to_inquirer]}.try(:to_s).presence
    end
    
    class << self
      attr_reader :view_file_options

      def set_view_file_options(options=nil)
        @view_file_options = options
      end

      def set_form(form)
        @form = form
        @form.set_item_class = self
      end

      def form
        @form ||= self.name.sub('Inquiry::', 'Form::').constantize
      end
      
    end

  end

end
