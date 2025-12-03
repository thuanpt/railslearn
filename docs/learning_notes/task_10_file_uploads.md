# Task 10: File Uploads (Active Storage)

**Ngày hoàn thành:** 03/12/2025  
**Mục tiêu:** Sử dụng Active Storage để upload và quản lý file (ảnh cover cho bài viết).

---

## 📚 Kiến thức đã học

### 1. Active Storage Setup

Active Storage là giải pháp built-in của Rails để quản lý file upload. Nó hỗ trợ upload lên local disk hoặc các cloud services (S3, GCS, Azure).

**Cài đặt:**
```bash
bin/rails active_storage:install
bin/rails db:migrate
```
Lệnh này tạo 3 bảng: `active_storage_blobs`, `active_storage_attachments`, `active_storage_variant_records`.

### 2. Model Configuration

Để gắn file vào model, dùng `has_one_attached` (hoặc `has_many_attached`).

```ruby
class Article < ApplicationRecord
  has_one_attached :cover_image
end
```

### 3. Controller & Views

**Controller:** Permit tham số file.
```ruby
params.require(:article).permit(:cover_image, ...)
```

**View Form:**
```erb
<%= form.file_field :cover_image %>
```

**View Display:**
```erb
<% if @article.cover_image.attached? %>
  <%= image_tag @article.cover_image %>
<% end %>
```

---

## 💻 Code đã viết

### 1. Setup
- Chạy installer và migration cho Active Storage.

### 2. Article Implementation
- **Model**: Thêm `has_one_attached :cover_image`.
- **Controller**: Permit `cover_image`.
- **View**:
    - `_form.html.erb`: Thêm input file.
    - `show.html.erb`: Hiển thị ảnh nếu có.

---

## 🔑 Khái niệm quan trọng

### 1. Blob vs Attachment
- **Blob**: Chứa metadata của file (filename, content_type, checksum...).
- **Attachment**: Bảng trung gian nối Model (Article) với Blob.

### 2. Storage Services
Mặc định Rails dùng `Disk` service (lưu local). Cấu hình trong `config/storage.yml`.

---

## ✅ Checklist hoàn thành

- [x] Install Active Storage
- [x] Config Model `has_one_attached`
- [x] Update Form Upload
- [x] Update Show View
- [x] Verify Backend (Script)

---

## 🎯 Kết quả Verification

Script `verify_task_10.rb` đã chạy thành công:
1. ✅ **Upload**: Tạo Article và attach file thành công.
2. ✅ **Blob**: Blob được tạo đúng trong database với metadata chính xác.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Active Storage](https://guides.rubyonrails.org/active_storage_overview.html)

---

## ➡️ Tiếp theo

**Phase 4: Authentication & Authorization** (Task 11: User Authentication)
