# Task 15: API Development

**Ngày hoàn thành:** 04/12/2025  
**Mục tiêu:** Xây dựng RESTful JSON API cho Articles, hỗ trợ versioning (V1).

---

## 📚 Kiến thức đã học

### 1. API Controller

Để xây dựng API, chúng ta sử dụng `ActionController::API` thay vì `ActionController::Base`.
- Nhẹ hơn (không có module render view HTML, flash, cookies mặc định).
- Tối ưu cho việc trả về JSON/XML.

```ruby
class Api::V1::ArticlesController < ActionController::API
end
```

### 2. Versioning

Versioning là rất quan trọng để tránh breaking changes cho client khi API thay đổi.
Cách phổ biến là dùng URL namespace: `/api/v1/articles`.

```ruby
namespace :api do
  namespace :v1 do
    resources :articles
  end
end
```

### 3. JSON Response

Sử dụng `render json: object` để Rails tự động serialize object thành JSON.
- `status: :created` (201) cho POST thành công.
- `status: :unprocessable_entity` (422) cho lỗi validation.
- `status: :not_found` (404) khi không tìm thấy record.

---

## 💻 Code đã viết

### 1. Routes
- Cấu hình namespace `api/v1` trong `config/routes.rb`.

### 2. Controller
- `Api::V1::ArticlesController`:
    - `index`: Trả về danh sách articles.
    - `show`: Trả về chi tiết article.
    - `create`: Tạo article mới (gán default user).
    - `update`: Cập nhật article.
    - `destroy`: Xóa article.
    - `rescue_from ActiveRecord::RecordNotFound`: Xử lý lỗi 404.

---

## 🔑 Khái niệm quan trọng

### 1. `head :no_content`
Trả về status 204 (No Content) và body rỗng. Thường dùng cho action `destroy` thành công.

### 2. `rescue_from`
Bắt exception ở mức Controller class, giúp code action gọn gàng hơn (không cần `begin...rescue` trong từng action).

---

## ✅ Checklist hoàn thành

- [x] Configure API Routes (Namespace)
- [x] Create API Controller
- [x] Implement CRUD Actions
- [x] Handle Errors (404)
- [x] Verify API (Script)

---

## 🎯 Kết quả Verification

Script `verify_task_15.rb` đã xác nhận:
1.  **GET Index**: Trả về danh sách JSON (200 OK).
2.  **POST Create**: Tạo bài viết thành công (201 Created).
3.  **GET Show**: Lấy bài viết vừa tạo (200 OK).
4.  **PUT Update**: Cập nhật tiêu đề (200 OK).
5.  **DELETE**: Xóa bài viết (204 No Content).
6.  **Error**: Trả về 404 khi ID không tồn tại.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Using Rails for API-only Applications](https://guides.rubyonrails.org/api_app.html)

---

## ➡️ Tiếp theo

Task 16: Background Jobs (Sắp tới)
