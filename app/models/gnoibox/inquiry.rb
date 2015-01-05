module Gnoibox
  class Inquiry < ActiveRecord::Base
    include ColumnHoldable

    self.table_name= :gnoibox_inquiries

    EMAIL_VALIDATION = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    scope :recent, ->{ order(created_at: :desc) }

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

    def save_and_notify
      save.tap do |result|
        if result
          base_info = Gnoibox::BlockCollection::load(:base_info)
          Gnoibox::InquiryMailer.notice(self, base_info).deliver
          Gnoibox::InquiryMailer.thank_if_possible(self, base_info).deliver
        end
      end
    end
    
    def inquirer_address
      #FIXME: detect inquiery_address
      nil
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
