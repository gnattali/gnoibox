class Gnoibox::InquiriesController < Gnoibox::ApplicationController
  before_action :set_form
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]

  def index
    @inquiries = @form.inquiries.page(params[:page]).per(1000)
  end

  def show
  end

  private
    def set_form
      @form = Gnoibox::FormCollection.find(params[:form_id])
    end

    def set_inquiry
      @inquiry = @form.find_inquiry(params[:id])
    end
end
