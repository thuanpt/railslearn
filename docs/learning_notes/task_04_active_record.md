# Task 4: Active Record Basics (Migrations, Models, Scopes)

**Ngày hoàn thành:** 28/11/2025  
**Mục tiêu:** Hiểu sâu về Active Record, Migrations và Model Validations

---

## 📚 Kiến thức đã học

### 1. Migrations

Migrations là cách Rails quản lý thay đổi database schema theo thời gian.

**Lệnh tạo migration:**
```bash
rails generate migration AddDetailsToArticles view_count:integer status:integer
rails generate model Category name:string
```

**File Migration:**
```ruby
class AddDetailsToArticles < ActiveRecord::Migration[8.1]
  def change
    add_column :articles, :view_count, :integer, default: 0
    add_column :articles, :status, :integer, default: 0
  end
end
```

### 2. Model Validations

Validations đảm bảo data hợp lệ trước khi lưu vào database.

```ruby
class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true, length: { minimum: 10 }
end
```

### 3. Enums

Enums map integer trong database thành trạng thái dễ đọc trong code.

```ruby
class Article < ApplicationRecord
  enum :status, { draft: 0, published: 1, archived: 2 }
end
```

**Sử dụng:**
```ruby
article.published?  # => true/false
article.published!  # Update status to published
Article.published   # Scope lấy tất cả published articles
```

### 4. Scopes

Scopes là các query thường dùng được đặt tên.

```ruby
class Article < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }
  scope :popular, -> { order(view_count: :desc) }
end
```

**Sử dụng:**
```ruby
Article.recent.limit(5)
Article.published.popular
```

---

## 💻 Code đã viết

### 1. Article Model Refactoring
**File:** `app/models/article.rb`
- Thêm `enum :status`
- Thêm validations cho title và body
- Thêm scopes `recent` và `popular`

### 2. Category Model
**File:** `app/models/category.rb`
- Tạo mới model
- Thêm validation `uniqueness` cho name

### 3. Database Schema
- Thêm bảng `categories`
- Thêm cột `view_count` và `status` vào `articles`

---

## 🔑 Khái niệm quan trọng

### 1. `validates`
Các helper phổ biến: `presence`, `uniqueness`, `length`, `numericality`, `format`.

### 2. `enum`
Giúp code dễ đọc hơn rất nhiều so với dùng magic numbers (0, 1, 2).

### 3. `scope`
Giúp tái sử dụng logic query, code gọn gàng hơn và có thể chain các scope với nhau.

---

## ✅ Checklist hoàn thành

- [x] Tạo migration thêm cột cho Articles
- [x] Tạo model Category
- [x] Chạy migrations
- [x] Thêm Validations
- [x] Thêm Enums
- [x] Thêm Scopes
- [x] Update seeds data
- [x] Verify bằng script

---

## 🎯 Kết quả Verification

Script `verify_task_4.rb` đã chạy thành công:
1. ✅ **Validations**: Chặn được article không hợp lệ
2. ✅ **Enums**: Check status hoạt động đúng
3. ✅ **Scopes**: Query data chính xác
4. ✅ **Uniqueness**: Chặn được duplicate category name

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Active Record Migrations](https://guides.rubyonrails.org/active_record_migrations.html)
- [Rails Guides - Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html)
- [Rails Guides - Active Record Query Interface](https://guides.rubyonrails.org/active_record_querying.html)

---

## ➡️ Tiếp theo

Task 5: Model Validations (Nâng cao & Custom Validations)
