# Task 11: User Authentication (has_secure_password)

**Ngày hoàn thành:** 03/12/2025  
**Mục tiêu:** Xây dựng hệ thống Authentication từ đầu (from scratch) sử dụng `has_secure_password` của Rails.

---

## 📚 Kiến thức đã học

### 1. `has_secure_password`

Đây là method của Active Model giúp thêm chức năng xác thực mật khẩu vào model một cách dễ dàng.
Yêu cầu:
- Gem `bcrypt`.
- Cột `password_digest` trong bảng users.

Nó tự động thêm:
- Thuộc tính ảo `password` và `password_confirmation`.
- Validations (presence, confirmation).
- Method `authenticate(password)` để kiểm tra mật khẩu.

### 2. Session Management

Authentication trong Rails thường dựa trên **Session**.
- **Login**: Lưu `user_id` vào `session[:user_id]`.
- **Logout**: Xóa `session[:user_id]` (gán bằng `nil`).
- **Current User**: Tìm user dựa trên `session[:user_id]`.

```ruby
# ApplicationController
def current_user
  @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
end
```

### 3. Controllers Flow

- **UsersController**: Xử lý đăng ký (Sign Up).
- **SessionsController**: Xử lý đăng nhập/đăng xuất (Login/Logout).

---

## 💻 Code đã viết

### 1. Model
- `User` model với `has_secure_password`.
- Validations cho name, email, password.

### 2. Controllers
- `UsersController#create`: Tạo user mới và auto-login.
- `SessionsController#create`: Tìm user và `authenticate`, sau đó set session.
- `SessionsController#destroy`: Clear session.
- `ApplicationController`: Helper `current_user`, `logged_in?`.

### 3. Views
- Form Sign Up (`users/new`).
- Form Login (`sessions/new`).
- Header update: Hiển thị tên user khi đã login, ngược lại hiện nút Login/Sign Up.

---

## 🔑 Khái niệm quan trọng

### 1. `bcrypt`
Thư viện hashing password. Nó dùng thuật toán Blowfish để mã hóa password một cách an toàn (one-way hash + salt).

### 2. `helper_method`
Giúp các method trong Controller có thể được gọi từ View.
```ruby
helper_method :current_user, :logged_in?
```

### 3. `flash.now` vs `flash`
- `flash[:notice]`: Tồn tại cho đến request tiếp theo (dùng cho redirect).
- `flash.now[:alert]`: Chỉ tồn tại trong request hiện tại (dùng cho render).

---

## ✅ Checklist hoàn thành

- [x] Enable `bcrypt`
- [x] Create User Model
- [x] Implement Sign Up
- [x] Implement Login/Logout
- [x] Update Header UI
- [x] Verify Flow (Browser & Script)

---

## 🎯 Kết quả Verification

1.  **Script**: `verify_task_11.rb` xác nhận logic tạo user và authenticate hoạt động đúng.
2.  **Browser**: Đã test luồng Đăng ký -> Tự động đăng nhập -> Đăng xuất -> Đăng nhập lại.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Active Model Basics (SecurePassword)](https://guides.rubyonrails.org/active_model_basics.html#securepassword)
- [Rails API - has_secure_password](https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html)

---

## ➡️ Tiếp theo

Task 12: Authorization (Pundit/Custom)
