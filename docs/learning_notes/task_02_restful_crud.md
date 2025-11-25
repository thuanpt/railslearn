# Task 2: Routes & Controllers (RESTful & CRUD)

**Ngày hoàn thành:** 25/11/2025  
**Mục tiêu:** Học RESTful routes và xây dựng CRUD đầy đủ

---

## 📚 Kiến thức đã học

### REST và RESTful Routes

**REST** (Representational State Transfer) là architectural style cho web services.

Rails cung cấp **7 RESTful actions chuẩn** cho mỗi resource:

| Action | HTTP Method | Path | Mục đích |
|--------|-------------|------|----------|
| `index` | GET | `/articles` | Danh sách tất cả |
| `show` | GET | `/articles/:id` | Chi tiết 1 item |
| `new` | GET | `/articles/new` | Form tạo mới |
| `create` | POST | `/articles` | Xử lý tạo mới |
| `edit` | GET | `/articles/:id/edit` | Form chỉnh sửa |
| `update` | PATCH/PUT | `/articles/:id` | Xử lý cập nhật |
| `destroy` | DELETE | `/articles/:id` | Xóa item |

### CRUD Operations

- **C**reate - Tạo mới (new + create)
- **R**ead - Đọc (index + show)
- **U**pdate - Cập nhật (edit + update)
- **D**elete - Xóa (destroy)

---

## 💻 Code đã viết

### 1. Model & Migration

**Tạo model:**
```bash
rails generate model Article title:string body:text published:boolean
rails db:migrate
```

**Migration file:**
```ruby
class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.boolean :published
      
      t.timestamps  # created_at, updated_at
    end
  end
end
```

**Model file:**
```ruby
class Article < ApplicationRecord
  # Validations sẽ được học ở Task 5
end
```

### 2. Routes

**File:** `config/routes.rb`

```ruby
Rails.application.routes.draw do
  resources :articles  # Tạo tự động 7 RESTful routes
end
```

**Xem routes đã tạo:**
```bash
rails routes | grep articles
```

**Kết quả:**
```
      articles GET    /articles           articles#index
               POST   /articles           articles#create
   new_article GET    /articles/new       articles#new
  edit_article GET    /articles/:id/edit  articles#edit
       article GET    /articles/:id       articles#show
               PATCH  /articles/:id       articles#update
               PUT    /articles/:id       articles#update
               DELETE /articles/:id       articles#destroy
```

### 3. Controller với đầy đủ 7 actions

**File:** `app/controllers/articles_controller.rb`

```ruby
class ArticlesController < ApplicationController
  # Callback: chạy trước các action được chỉ định
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  # GET /articles
  def index
    @articles = Article.all.order(created_at: :desc)
  end
  
  # GET /articles/:id
  def show
    # @article đã được set bởi before_action
  end
  
  # GET /articles/new
  def new
    @article = Article.new
  end
  
  # POST /articles
  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article, notice: "Article được tạo thành công!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # GET /articles/:id/edit
  def edit
    # @article đã được set bởi before_action
  end
  
  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article được cập nhật thành công!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # DELETE /articles/:id
  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article đã được xóa!"
  end
  
  private
  
  # Callback để tìm article theo ID
  def set_article
    @article = Article.find(params[:id])
  end
  
  # Strong parameters - bảo mật
  def article_params
    params.require(:article).permit(:title, :body, :published)
  end
end
```

### 4. Views

**Cấu trúc thư mục:**
```
app/views/articles/
├── index.html.erb    # Danh sách
├── show.html.erb     # Chi tiết
├── new.html.erb      # Form tạo mới
├── edit.html.erb     # Form chỉnh sửa
└── _form.html.erb    # Partial form dùng chung
```

**View: index.html.erb**
```erb
<h1>Danh Sách Articles</h1>
<%= link_to "Tạo Article Mới", new_article_path %>

<% @articles.each do |article| %>
  <div>
    <h2><%= link_to article.title, article %></h2>
    <p><%= truncate(article.body, length: 200) %></p>
    
    <%= link_to "Xem", article %>
    <%= link_to "Sửa", edit_article_path(article) %>
    <%= link_to "Xóa", article, 
        data: { turbo_method: :delete, turbo_confirm: "Chắc chắn?" } %>
  </div>
<% end %>
```

**View: show.html.erb**
```erb
<%= link_to "← Quay lại", articles_path %>

<h1><%= @article.title %></h1>
<p><%= simple_format(@article.body) %></p>

<%= link_to "Chỉnh sửa", edit_article_path(@article) %>
<%= link_to "Xóa", @article, 
    data: { turbo_method: :delete, turbo_confirm: "Chắc chắn?" } %>
```

**View: new.html.erb**
```erb
<h1>Tạo Article Mới</h1>
<%= render "form", article: @article %>
```

**View: edit.html.erb**
```erb
<h1>Chỉnh Sửa Article</h1>
<%= render "form", article: @article %>
```

**Partial: _form.html.erb**
```erb
<%= form_with(model: article) do |form| %>
  <!-- Hiển thị errors -->
  <% if article.errors.any? %>
    <div>
      <h3><%= pluralize(article.errors.count, "lỗi") %></h3>
      <ul>
        <% article.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <!-- Title field -->
  <%= form.label :title, "Tiêu đề:" %>
  <%= form.text_field :title %>

  <!-- Body field -->
  <%= form.label :body, "Nội dung:" %>
  <%= form.text_area :body, rows: 10 %>

  <!-- Published checkbox -->
  <%= form.check_box :published %>
  <%= form.label :published, "Xuất bản ngay" %>

  <!-- Submit -->
  <%= form.submit article.new_record? ? "Tạo Article" : "Cập Nhật" %>
  <%= link_to "Hủy", articles_path %>
<% end %>
```

---

## 🔑 Khái niệm quan trọng

### 1. Resources Routes

```ruby
resources :articles
```

Một dòng này tạo tự động 7 routes với path helpers:
- `articles_path` → `/articles`
- `article_path(@article)` → `/articles/:id`
- `new_article_path` → `/articles/new`
- `edit_article_path(@article)` → `/articles/:id/edit`

### 2. Strong Parameters

**Vấn đề:** Mass assignment vulnerability - user có thể gửi bất kỳ params nào

**Giải pháp:** Chỉ cho phép các attributes an toàn

```ruby
def article_params
  params.require(:article).permit(:title, :body, :published)
end
```

### 3. before_action Callback

```ruby
before_action :set_article, only: [:show, :edit, :update, :destroy]

def set_article
  @article = Article.find(params[:id])
end
```

Chạy `set_article` trước khi vào các action được chỉ định.

### 4. redirect_to vs render

**redirect_to:** Tạo HTTP redirect (new request)
```ruby
redirect_to @article  # Chuyển đến show page
redirect_to articles_path  # Chuyển đến index page
```

**render:** Render view trực tiếp (same request)
```ruby
render :new  # Render lại form new với errors
render :edit, status: :unprocessable_entity
```

### 5. Form Helpers

```erb
<%= form_with(model: article) do |form| %>
  <%= form.text_field :title %>
  <%= form.text_area :body %>
  <%= form.check_box :published %>
  <%= form.submit %>
<% end %>
```

**form_with** tự động:
- Biết action (create nếu new record, update nếu existing)
- Điền sẵn giá trị nếu là edit form
- Set đúng HTTP method (POST hoặc PATCH)

### 6. Link Helpers cho CRUD

```erb
<!-- READ -->
<%= link_to "Articles", articles_path %>        # GET /articles
<%= link_to "View", article %>                   # GET /articles/:id

<!-- CREATE -->
<%= link_to "New", new_article_path %>          # GET /articles/new

<!-- UPDATE -->
<%= link_to "Edit", edit_article_path(article) %> # GET /articles/:id/edit

<!-- DELETE -->
<%= link_to "Delete", article, 
    data: { turbo_method: :delete, turbo_confirm: "Sure?" } %>
```

### 7. Partials

File bắt đầu bằng `_` (underscore):
```
_form.html.erb
```

Render partial:
```erb
<%= render "form", article: @article %>
```

Truyền biến local `article` vào partial.

---

## 🗄️ Database Commands

```bash
# Tạo migration
rails generate model Article title:string body:text

# Chạy migration
rails db:migrate

# Rollback migration gần nhất
rails db:rollback

# Reset database
rails db:reset

# Seed data
rails db:seed
```

---

## 💾 Seed Data

**File:** `db/seeds.rb`

```ruby
Article.create!([
  {
    title: "Bắt Đầu Với Ruby on Rails",
    body: "Rails là một web framework mạnh mẽ...",
    published: true
  },
  {
    title: "MVC Architecture",
    body: "MVC là design pattern...",
    published: true
  }
])
```

Chạy seed:
```bash
rails db:seed
```

---

## ✅ Checklist hoàn thành

- [x] Tạo model Article với migration
- [x] Cấu hình resources routes
- [x] Tạo ArticlesController với 7 actions
- [x] Implement index action (READ all)
- [x] Implement show action (READ one)
- [x] Implement new + create actions (CREATE)
- [x] Implement edit + update actions (UPDATE)
- [x] Implement destroy action (DELETE)
- [x] Tạo đầy đủ views
- [x] Tạo form partial
- [x] Sử dụng strong parameters
- [x] Test CRUD operations trong browser

---

## 🎯 Đã test thành công

1. ✅ **Index**: Xem danh sách articles
2. ✅ **Show**: Xem chi tiết article
3. ✅ **New**: Hiển thị form tạo mới
4. ✅ **Create**: Tạo "Test Article" thành công
5. ✅ **Edit**: Hiển thị form chỉnh sửa với data đã có
6. ✅ **Update**: Cập nhật article
7. ✅ **Destroy**: Xóa article

---

## 📊 Flow hoàn chỉnh

### CREATE Flow
```
GET /articles/new
  → ArticlesController#new
  → Render form
  
POST /articles (with params)
  → ArticlesController#create
  → Article.new(params)
  → Save success? → Redirect to show
  → Save fail? → Render :new with errors
```

### UPDATE Flow
```
GET /articles/:id/edit
  → ArticlesController#edit
  → Find article
  → Render form with data
  
PATCH /articles/:id (with params)
  → ArticlesController#update
  → Find article
  → Update success? → Redirect to show
  → Update fail? → Render :edit with errors
```

### DELETE Flow
```
DELETE /articles/:id
  → ArticlesController#destroy
  → Find article
  → Destroy
  → Redirect to index
```

---

## 📝 Ghi chú

- **Turbo** (Rails 7+) xử lý form submissions qua AJAX mặc định
- `data: { turbo_method: :delete }` để gửi DELETE request
- `data: { turbo_confirm: "Message" }` để confirm trước khi action
- `notice` và `alert` được Rails tự động hiển thị (nếu có flash message rendering)
- Partials giúp tránh code duplication giữa new và edit forms

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Routing](https://guides.rubyonrails.org/routing.html)
- [Rails Guides - Action Controller Overview](https://guides.rubyonrails.org/action_controller_overview.html)
- [Rails Guides - Form Helpers](https://guides.rubyonrails.org/form_helpers.html)
- [Rails Guides - Active Record Basics](https://guides.rubyonrails.org/active_record_basics.html)

---

## ➡️ Tiếp theo

Task 3: Views & ERB Templates (Layouts, Partials, Helpers)
