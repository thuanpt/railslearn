# Task 3: Views & ERB Templates (Layouts, Partials, Helpers)

**Ngày hoàn thành:** 28/11/2025  
**Mục tiêu:** Master Rails Views, Layouts, Partials và Asset Pipeline

---

## 📚 Kiến thức đã học

### 1. Layouts (`app/views/layouts/`)

Layout là template bao bọc các view khác. Mặc định Rails dùng `application.html.erb`.

```erb
<!-- app/views/layouts/application.html.erb -->
<body>
  <%= render "shared/header" %>  <!-- Render partial header -->
  
  <main class="container">
    <%= yield %>                 <!-- Nội dung của từng view sẽ được chèn vào đây -->
  </main>
  
  <%= render "shared/footer" %>  <!-- Render partial footer -->
</body>
```

### 2. Partials (`_partial.html.erb`)

Partials giúp chia nhỏ view thành các component tái sử dụng được.
- Tên file bắt đầu bằng dấu gạch dưới `_`.
- Gọi bằng `<%= render "folder/file" %>` (không cần dấu `_`).

**Ví dụ:** `app/views/shared/_header.html.erb`

### 3. Helpers (`app/helpers/`)

Helpers là các Ruby module chứa logic hiển thị, giúp view gọn gàng hơn.

```ruby
# app/helpers/application_helper.rb
module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Myapp"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
```

**Sử dụng trong View:**
```erb
<title><%= full_title(yield(:title)) %></title>
```

### 4. Asset Pipeline (CSS)

Rails (với Propshaft) quản lý assets trong `app/assets/`.
- **Stylesheets**: `app/assets/stylesheets/`
- **Images**: `app/assets/images/`

Chúng ta đã tạo `application.css` với CSS Variables để quản lý màu sắc tập trung.

```css
:root {
  --primary-color: #2563eb;
  --text-color: #1f2937;
}
```

---

## 💻 Code đã viết

### 1. Header Partial
**File:** `app/views/shared/_header.html.erb`
- Navigation bar với links
- Logic `active` class cho link hiện tại

### 2. Footer Partial
**File:** `app/views/shared/_footer.html.erb`
- Copyright info
- Quick links

### 3. Application Layout
**File:** `app/views/layouts/application.html.erb`
- Tích hợp Header & Footer
- Thêm Flash messages display
- Container wrapper

### 4. Styling
**File:** `app/assets/stylesheets/application.css`
- Design system (Colors, Typography)
- Components (Buttons, Cards, Alerts)
- Responsive utilities

---

## 🔑 Khái niệm quan trọng

### 1. `yield`
Từ khóa để xác định vị trí chèn nội dung của view con vào layout.

### 2. `content_for` & `provide`
Dùng để truyền nội dung từ view lên layout (ví dụ: title).

```erb
<!-- Trong view -->
<% provide(:title, "Home") %>

<!-- Trong layout -->
<title><%= yield(:title) %></title>
```

### 3. `render`
Dùng để gọi partials.

### 4. CSS Variables
Giúp quản lý theme dễ dàng hơn. Thay vì hardcode mã màu hex khắp nơi, ta dùng `var(--primary-color)`.

---

## ✅ Checklist hoàn thành

- [x] Tạo `shared/header` và `shared/footer` partials
- [x] Cập nhật `application.html.erb` layout
- [x] Viết `full_title` helper
- [x] Tạo design system trong `application.css`
- [x] Refactor Home page dùng class mới
- [x] Refactor Articles Index page dùng class mới
- [x] Verify giao diện trên browser

---

## 🎯 Kết quả

Giao diện ứng dụng đã được nâng cấp chuyên nghiệp hơn:
- **Consistent**: Màu sắc và spacing đồng nhất
- **Responsive**: Hiển thị tốt trên mobile
- **Maintainable**: Code CSS và HTML được tổ chức gọn gàng

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Layouts and Rendering](https://guides.rubyonrails.org/layouts_and_rendering.html)
- [Rails Guides - Asset Pipeline](https://guides.rubyonrails.org/asset_pipeline.html)

---

## ➡️ Tiếp theo

Task 4: Active Record Basics (Migrations, Models, Database)
