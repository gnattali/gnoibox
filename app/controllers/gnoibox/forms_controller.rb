class Gnoibox::FormsController < Gnoibox::ApplicationController
  before_action :set_form, only: [:show]

  def index
    @forms = Gnoibox::FormCollection.all
  end

  def show
    redirect_to gnoibox_form_inquiries_path(@form)
  end

  private
    def set_form
      @form = Gnoibox::FormCollection.find(params[:id])
    end
end
