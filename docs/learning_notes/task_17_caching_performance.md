# Task 17: Caching & Performance

**Ngày hoàn thành:** 04/12/2025  
**Mục tiêu:** Tối ưu hóa hiệu năng ứng dụng bằng cách giảm số lượng truy vấn database (N+1 Queries) và sử dụng Caching.

---

## 📚 Kiến thức đã học

### 1. N+1 Queries Problem

Vấn đề xảy ra khi code thực hiện 1 truy vấn để lấy danh sách cha (N articles), sau đó thực hiện thêm N truy vấn để lấy thông tin con (User/Category) cho mỗi phần tử.
- **Hậu quả**: Database bị quá tải với hàng trăm câu lệnh SQL nhỏ.
- **Giải pháp**: Eager Loading (`includes`).

```ruby
# Bad (N+1)
@articles = Article.all
# View: article.user.name -> SELECT * FROM users WHERE id = ?

# Good (Eager Loading)
@articles = Article.includes(:user, :category).all
# Rails: SELECT * FROM articles
# Rails: SELECT * FROM users WHERE id IN (...)
# Rails: SELECT * FROM categories WHERE id IN (...)
```

### 2. Fragment Caching

Rails cho phép cache từng phần nhỏ của view (fragment).
- **Key-based expiration**: Cache key thường bao gồm `updated_at` của object. Khi object thay đổi, key thay đổi -> cache cũ tự động hết hạn.
- **Russian Doll Caching**: Cache lồng nhau.

```erb
<% cache article do %>
  <!-- HTML rendering logic -->
<% end %>
```

---

## 💻 Code đã viết

### 1. Controller
- `ArticlesController`: Thêm `.includes(:user, :category)` vào action `index`.

### 2. View
- `app/views/articles/index.html.erb`: Thêm block `<% cache article do %>` bao quanh mỗi article card.

---

## 🔑 Khái niệm quan trọng

### 1. `includes` vs `joins`
- `includes`: Dùng để Eager Loading (lấy dữ liệu liên quan để dùng sau này).
- `joins`: Dùng để lọc dữ liệu (INNER JOIN), không load dữ liệu bảng liên quan vào memory.

### 2. Cache Store
Trong development, Rails mặc định dùng `:memory_store`. Trong production, thường dùng Redis hoặc Memcached.

---

## ✅ Checklist hoàn thành

- [x] Identify N+1 Queries
- [x] Fix N+1 Queries (`includes`)
- [x] Implement Fragment Caching (`cache` helper)
- [x] Verify Performance Logic (Script)

---

## 🎯 Kết quả Verification

Script `verify_task_17.rb` đã xác nhận:
1.  **Eager Loading**: Code chạy hiệu quả hơn về mặt logic truy vấn.
2.  **Caching**: Syntax cache đã được áp dụng đúng trong View.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Caching with Rails](https://guides.rubyonrails.org/caching_with_rails.html)
- [Rails Guides - Active Record Query Interface (Eager Loading)](https://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations)

---

## ➡️ Tiếp theo

Task 18: Deployment (Sắp tới)
