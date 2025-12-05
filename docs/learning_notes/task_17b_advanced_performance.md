# Task 17b: Advanced Performance

**Ngày hoàn thành:** 05/12/2025  
**Mục tiêu:** Tối ưu hóa Database với Indexing và cấu hình Redis Cache cho production.

---

## 📚 Kiến thức đã học

### 1. Database Indexing

Indexing giúp database tìm kiếm dữ liệu nhanh hơn mà không cần quét toàn bộ bảng (Full Table Scan).
- **Foreign Keys**: Luôn nên index các cột khóa ngoại (`user_id`, `category_id`, `article_id`...) vì chúng thường xuyên được dùng trong `JOIN` hoặc `WHERE`.
- **Polymorphic Association**: Rails tự động tạo index cho `[commentable_type, commentable_id]`.

### 2. Redis Cache Store

Sử dụng Redis làm backend cho Rails Cache thay vì Memory Store.
- **Ưu điểm**:
    - **Persistence**: Cache không bị mất khi restart web server.
    - **Shared**: Nhiều server/process có thể dùng chung cache.
    - **Performance**: Redis rất nhanh (in-memory).

---

## 💻 Code đã viết

### 1. Database
- Kiểm tra và xác nhận các index đã tồn tại:
    - `articles`: `user_id`, `category_id`.
    - `comments`: `commentable_type`, `commentable_id`.

### 2. Configuration
- `config/environments/development.rb`:
    - Chuyển `config.cache_store` sang `:redis_cache_store`.
    - URL: `redis://localhost:6379/0`.

---

## ⚠️ Yêu cầu hệ thống (Redis)

Tương tự như Sidekiq, tính năng Caching này yêu cầu **Redis** phải đang chạy.
Nếu Redis chưa chạy, Rails sẽ không thể ghi/đọc cache (trả về `nil`).

---

## ✅ Checklist hoàn thành

- [x] Verify Database Indexes
- [x] Add `redis` Gem
- [x] Configure `redis_cache_store`
- [ ] Verify Redis Cache (Requires Redis)

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Caching with Rails](https://guides.rubyonrails.org/caching_with_rails.html#redis-cache-store)
- [Rails Guides - Active Record Migrations (Indexes)](https://guides.rubyonrails.org/active_record_migrations.html#creating-indexes)

---

## ➡️ Tiếp theo

Task 18: Deployment (Sắp tới)
