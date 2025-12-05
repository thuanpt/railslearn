# Task 15b: API Authentication (JWT)

**Ngày hoàn thành:** 05/12/2025  
**Mục tiêu:** Bảo mật API bằng JSON Web Token (JWT).

---

## 📚 Kiến thức đã học

### 1. JSON Web Token (JWT)

JWT là một chuẩn mở (RFC 7519) định nghĩa cách truyền tải thông tin an toàn giữa các bên dưới dạng đối tượng JSON.
- **Cấu trúc**: `Header.Payload.Signature`
- **Stateless**: Server không cần lưu session. Client gửi token trong mỗi request để xác thực.

### 2. Authentication Flow

1.  **Login**: Client gửi Email/Password -> Server kiểm tra -> Trả về Token.
2.  **Request**: Client gửi Token trong Header `Authorization: Bearer <token>`.
3.  **Verify**: Server decode Token -> Lấy User ID -> Xác thực User -> Cho phép/Chặn request.

---

## 💻 Code đã viết

### 1. Service
- `JsonWebToken`: Class tiện ích để `encode` (tạo token) và `decode` (giải mã token) sử dụng `Rails.application.secret_key_base`.

### 2. Controllers
- `Api::V1::AuthenticationController`: Xử lý đăng nhập (`login`).
- `Api::V1::ApplicationController`: Base controller chứa method `authorize_request` để kiểm tra token.
- `Api::V1::ArticlesController`: Sử dụng `before_action :authorize_request` để bảo vệ các action `create`, `update`, `destroy`.

---

## 🔑 Khái niệm quan trọng

### 1. `before_action`
Filter chạy trước khi action được thực thi. Nếu `authorize_request` trả về lỗi (render json), action chính sẽ không chạy.

### 2. `request.headers['Authorization']`
Nơi chứa token gửi lên từ client. Thường có dạng `Bearer eyJhbGci...`.

---

## ✅ Checklist hoàn thành

- [x] Add `jwt` Gem
- [x] Create `JsonWebToken` Service
- [x] Implement Login Endpoint
- [x] Protect Articles API
- [x] Verify Auth Flow (Script)

---

## 🎯 Kết quả Verification

Script `verify_task_15b.rb` đã xác nhận:
1.  **Unauthorized**: Request không có token bị trả về 401.
2.  **Login**: Đăng nhập đúng trả về Token hợp lệ.
3.  **Authorized**: Request có token tạo được bài viết thành công.

---

## 🔗 Tài liệu tham khảo

- [JWT.io Introduction](https://jwt.io/introduction)
- [Gem 'jwt' Documentation](https://github.com/jwt/ruby-jwt)

---

## ➡️ Tiếp theo

Task 16b: Real Emails & Sidekiq (Sắp tới)
