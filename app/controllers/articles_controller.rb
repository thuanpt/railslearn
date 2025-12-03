class ArticlesController < ApplicationController
  # Callback: chạy trước các action được chỉ định
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  # GET /articles - Hiển thị danh sách tất cả articles
  def index
    @articles = Article.all.order(created_at: :desc)
    # Rails tự động render: app/views/articles/index.html.erb
  end
  
  # GET /articles/:id - Hiển thị chi tiết 1 article
  def show
    # @article đã được set bởi before_action
  end
  
  # GET /articles/new - Hiển thị form tạo article mới
  def new
    @article = Article.new
  end
  
  # POST /articles - Xử lý tạo article mới
  def create
    @article = Article.new(article_params)
    
    if @article.save
      # Lưu thành công -> chuyển đến trang show
      redirect_to @article, notice: "Article được tạo thành công!"
    else
      # Lưu thất bại -> render lại form với errors
      render :new, status: :unprocessable_entity
    end
  end
  
  # GET /articles/:id/edit - Hiển thị form chỉnh sửa
  def edit
    # @article đã được set bởi before_action
  end
  
  # PATCH/PUT /articles/:id - Xử lý cập nhật
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article được cập nhật thành công!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # DELETE /articles/:id - Xóa article
  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article đã được xóa!"
  end
  
  private
  
  # Callback để tìm article theo ID
  def set_article
    @article = Article.find(params[:id])
  end
  
  # Strong parameters - chỉ cho phép các attributes được phép
  def article_params
    params.require(:article).permit(:title, :body, :published, :category_id, :tag_list, :cover_image, comments_attributes: [:id, :body, :_destroy])
  end
end
