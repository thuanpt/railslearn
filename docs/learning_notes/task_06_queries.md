# Task 6: Active Record Queries (Find, Where, Joins, Includes)

**Ngày hoàn thành:** 28/11/2025  
**Mục tiêu:** Master Active Record Query Interface và tối ưu hóa performance.

---

## 📚 Kiến thức đã học

### 1. Basic Finders

Cách tìm kiếm dữ liệu cơ bản:

```ruby
Article.find(1)                # Tìm theo ID (lỗi nếu không thấy)
Article.find_by(title: 'MVC')  # Tìm record đầu tiên khớp điều kiện (trả về nil nếu không thấy)
Article.first                  # Record đầu tiên
Article.last                   # Record cuối cùng
```

### 2. Conditions (`where`)

Lọc dữ liệu theo điều kiện:

```ruby
Article.where(status: :published)
Article.where("view_count > ?", 100)
Article.where.not(status: :archived)
```

### 3. Ordering & Limiting

Sắp xếp và giới hạn kết quả:

```ruby
Article.order(created_at: :desc).limit(5)
```

### 4. Aggregations

Tính toán trên database (nhanh hơn tính trên Ruby):

```ruby
Article.count
Article.average(:view_count)
Article.sum(:view_count)
Article.maximum(:view_count)
```

### 5. Associations & Joins

Query dựa trên quan hệ:

```ruby
# Tìm articles thuộc category 'Technology'
Article.joins(:category).where(categories: { name: 'Technology' })
```

### 6. N+1 Problem & Solution (`includes`)

**Vấn đề N+1:**
Khi loop qua danh sách articles và gọi `article.category.name`, Rails sẽ chạy 1 query để lấy articles + N query để lấy category cho từng article.

**Giải pháp:**
Sử dụng `includes` để Eager Load dữ liệu liên quan.

```ruby
# Bad (N+1 queries)
Article.all.each { |a| a.category.name }

# Good (2 queries)
Article.includes(:category).all.each { |a| a.category.name }
```

---

## 💻 Code đã viết

### 1. Migrations & Associations
- Thêm `category_id` vào `articles`.
- Link `Article` belongs_to `Category`.
- Link `Category` has_many `Articles`.

### 2. Practice Scripts
**File:** `practice_queries.rb`
- Demo các loại query từ cơ bản đến nâng cao.

**File:** `n_plus_one_demo.rb`
- Demo thực tế vấn đề N+1 và cách fix.

---

## 🔑 Khái niệm quan trọng

### 1. Lazy Loading
Active Record không chạy query ngay lập tức cho đến khi dữ liệu thực sự cần thiết (ví dụ khi gọi `.each`, `.count`).

### 2. Eager Loading
Load trước dữ liệu liên quan để giảm số lượng query. Dùng `includes` (thường dùng nhất), `preload`, hoặc `eager_load`.

### 3. SQL Injection Protection
Luôn dùng placeholder `?` hoặc hash syntax trong `where` để tránh SQL Injection.
**Bad:** `where("title = #{params[:title]}")`
**Good:** `where("title = ?", params[:title])`

---

## ✅ Checklist hoàn thành

- [x] Thêm quan hệ Article - Category
- [x] Update seeds data
- [x] Thực hành Basic Finders
- [x] Thực hành Where Conditions
- [x] Thực hành Aggregations
- [x] Demo & Fix N+1 Problem

---

## 🎯 Kết quả Verification

Script `n_plus_one_demo.rb` cho thấy sự khác biệt rõ rệt:
- **N+1**: Chạy 7 queries (1 cho articles + 6 cho categories).
- **Eager Loading**: Chạy 2 queries (1 cho articles + 1 cho categories).

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Active Record Query Interface](https://guides.rubyonrails.org/active_record_querying.html)
- [Rails Guides - Eager Loading Associations](https://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations)

---

## ➡️ Tiếp theo

Task 7: Associations (Deep Dive - Has Many Through, Polymorphic)
