class ArticlesController < ApplicationController

  def new
    @article = Article.new
    # puts @article.inspect
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

  def show
    @article = Article.find(params[:id])
    # render plain: @article.inspect
  end

  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end