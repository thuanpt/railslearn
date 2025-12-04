module Api
  module V1
    class ArticlesController < ActionController::API
      before_action :set_article, only: %i[ show update destroy ]

      # GET /api/v1/articles
      def index
        @articles = Article.all.order(created_at: :desc)
        render json: @articles
      end

      # GET /api/v1/articles/1
      def show
        render json: @article
      end

      # POST /api/v1/articles
      def create
        @article = Article.new(article_params)
        # For simplicity in this task, we might skip user association or assign a default user
        # In a real API, we'd use token authentication to identify the user.
        # For now, let's assign the first user to make it work.
        @article.user = User.first 

        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/articles/1
      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/articles/1
      def destroy
        @article.destroy!
        head :no_content
      end

      private
        def set_article
          @article = Article.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Article not found" }, status: :not_found
        end

        def article_params
          params.require(:article).permit(:title, :body, :status, :category_id, :published_at)
        end
    end
  end
end
