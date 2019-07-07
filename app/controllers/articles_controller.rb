class ArticlesController < ApplicationController
  before_action :get_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article = Article.new
    # puts @article.inspect
  end

  def edit
  end

  def create
    # puts '*' * 59
    # puts params
    # puts '*' * 59
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      # p '>' * 59
      flash[:success] = "Article was successfully created"
      puts flash
      redirect_to article_path(@article)
      # render plain: params[:article].inspect
    else
      # flash[:error] = "something went wrong"
      # @article.errors.full_messages.each do |error|
      #   flash[:error] = error
      # end
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else 
      render 'edit'
    end
  end

  def show
    # render plain: @article.inspect
  end

  def destroy
    @article.destroy
    flash[:danger] = "The artice \"#{@article.title}\" has been deleted"
    redirect_to articles_path
  end

  
  private
    def get_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "You can only edit or delete your own article"
        redirect_to user_path(current_user)
      end
    end

end