class ArticlesController < ApplicationController
  before_action :get_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all
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
    if @article.save
      p '>' * 59
      flash[:notice] = "Article was successfully created"
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
      flash[:notice] = "Article was successfully updated"
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
    flash[:notice] = "The artice \"#{@article.title}\" has been deleted"
    redirect_to articles_path
  end

  
  private
    def get_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

end