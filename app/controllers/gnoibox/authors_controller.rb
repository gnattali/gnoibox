class Gnoibox::AuthorsController < Gnoibox::ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Gnoibox::AuthorProfile.order(role: :asc).all
  end

  def new
    @author = Gnoibox::AuthorProfile.new
  end
  
  def create
    @author = Gnoibox::AuthorProfile.new(author_params)
    if @author.save
      redirect_to gnoibox_authors_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to gnoibox_authors_path, notice: '保存されました' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy
    redirect_to gnoibox_authors_url
  end

  private
    def set_author
      @author = Gnoibox::AuthorProfile.find(params[:id])
    end

    def author_params
      para = params[:author].permit!
      para.delete('password') if para[:password].blank?
      para.delete('password_confirmation') if para[:password_confirmation].blank?
      para
    end
    
    def form_url
      @author.id ? gnoibox_author_path(@author) : gnoibox_authors_path
    end
    helper_method :form_url

end
