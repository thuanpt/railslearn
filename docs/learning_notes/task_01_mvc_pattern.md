# Task 1: Hiểu MVC Pattern

**Ngày hoàn thành:** 20/11/2025  
**Mục tiêu:** Hiểu và thực hành MVC Pattern trong Rails

---

## 📚 Kiến thức đã học

### MVC là gì?

**MVC** (Model-View-Controller) là một design pattern phổ biến trong web development:

- **Model** (`app/models/`): Quản lý data và business logic, tương tác với database
- **View** (`app/views/`): Hiển thị giao diện người dùng (HTML, ERB templates)
- **Controller** (`app/controllers/`): Điều khiển logic, nhận request từ user, gọi Model và render View

### Request Flow trong Rails

```
Browser Request (GET /)
    ↓
Routes (config/routes.rb) - tìm route phù hợp
    ↓
Controller (PagesController#home) - xử lý logic
    ↓
View (app/views/pages/home.html.erb) - render HTML
    ↓
Response HTML về Browser
```

---

## 💻 Code đã viết

### 1. Controller (PagesController)

**File:** `app/controllers/pages_controller.rb`

```ruby
class PagesController < ApplicationController
  # Action để hiển thị trang chủ
  def home
    # Biến instance (@) có thể được sử dụng trong view
    @welcome_message = "Chào mừng đến với Rails!"
    @current_time = Time.now
    
    # Rails tự động render view: app/views/pages/home.html.erb
  end
  
  def about
    @description = "Đây là trang về chúng tôi"
  end
  
  def contact
    @email = "contact@example.com"
  end
end
```

**Các điểm quan trọng:**
- Controller kế thừa từ `ApplicationController`
- Mỗi action tương ứng với một trang
- Biến instance (`@variable`) có thể truy cập từ view
- Rails tự động render view có tên trùng với action

### 2. Routes (config/routes.rb)

```ruby
Rails.application.routes.draw do
  root "pages#home"                    # GET / -> PagesController#home
  get "about", to: "pages#about"       # GET /about -> PagesController#about
  get "contact", to: "pages#contact"   # GET /contact -> PagesController#contact
end
```

**Các điểm quan trọng:**
- `root` định nghĩa trang chủ
- `get` định nghĩa HTTP GET route
- Format: `"url" => "controller#action"`

### 3. Views (ERB Templates)

**File:** `app/views/pages/home.html.erb`

```erb
<h1><%= @welcome_message %></h1>
<p>Thời gian: <%= @current_time.strftime("%d/%m/%Y %H:%M:%S") %></p>

<!-- Vòng lặp -->
<% 3.times do |i| %>
  <p>Lặp lần <%= i + 1 %></p>
<% end %>

<!-- Link helper -->
<%= link_to "Về chúng tôi", about_path %>
```

**ERB Syntax:**
- `<%= %>` - In giá trị ra màn hình
- `<% %>` - Chạy Ruby code không in ra
- Có thể sử dụng bất kỳ Ruby code nào

---

## 🔑 Khái niệm quan trọng

### 1. Biến Instance (@variable)

```ruby
# Trong Controller
@welcome_message = "Hello"

# Trong View
<%= @welcome_message %>  # => "Hello"
```

### 2. ERB (Embedded Ruby)

- File có đuôi `.html.erb`
- Cho phép nhúng Ruby code vào HTML
- Được Rails compile thành HTML trước khi gửi về browser

### 3. Rails Helpers

```erb
<%= link_to "Text", path %>           # Tạo link
<%= link_to "About", about_path %>    # => <a href="/about">About</a>
```

### 4. Routing Helpers

Khi define routes, Rails tự động tạo helper methods:

```ruby
root "pages#home"          # => root_path, root_url
get "about" => "pages#about"  # => about_path, about_url
```

---

## 📁 Cấu trúc thư mục

```
app/
├── controllers/
│   ├── application_controller.rb
│   └── pages_controller.rb
├── views/
│   ├── layouts/
│   │   └── application.html.erb
│   └── pages/
│       ├── home.html.erb
│       ├── about.html.erb
│       └── contact.html.erb
config/
└── routes.rb
```

---

## ✅ Checklist hoàn thành

- [x] Hiểu MVC Pattern
- [x] Tạo PagesController với 3 actions
- [x] Tạo 3 views tương ứng
- [x] Cấu hình routes
- [x] Sử dụng ERB syntax
- [x] Truyền data từ controller sang view
- [x] Sử dụng link helpers

---

## 🎯 Bài tập thực hành đã làm

1. ✅ Tạo controller `PagesController`
2. ✅ Tạo các actions: `home`, `about`, `contact`
3. ✅ Tạo views tương ứng
4. ✅ Cấu hình routes
5. ✅ Sử dụng biến instance
6. ✅ Chạy server và test trên browser

---

## 📝 Ghi chú

- Convention over Configuration: Rails tự động tìm view dựa trên tên action
- View folder phải trùng tên với controller (pages_controller.rb → views/pages/)
- Rails tự động render view, không cần gọi `render` explicitly
- `link_to` helper tạo thẻ `<a>` với các thuộc tính phù hợp

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Controllers](https://guides.rubyonrails.org/action_controller_overview.html)
- [Rails Guides - Routing](https://guides.rubyonrails.org/routing.html)
- [Rails Guides - Layouts and Rendering](https://guides.rubyonrails.org/layouts_and_rendering.html)

---

## ➡️ Tiếp theo

Task 2: Routes & Controllers (RESTful & CRUD)
