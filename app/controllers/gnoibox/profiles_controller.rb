class Gnoibox::ProfilesController < Gnoibox::ApplicationController
  before_action :set_author, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to gnoibox_root_path, notice: '保存されました' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_author
      @author = Gnoibox::AuthorProfile.find(current_gnoibox_gnoibox_author.id)
    end

    def author_params
      para = params[:author].permit!
      para.delete('password') if para[:password].blank?
      para.delete('password_confirmation') if para[:password_confirmation].blank?
      para
    end

    def form_url
      gnoibox_profile_path
    end
    helper_method :form_url

end
