class ArticlesController < ApplicationController
  def index
    current_page = (params[:page] || 1).to_i
    @articles = Article.order(created_at: :desc).page(current_page).per(1)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
