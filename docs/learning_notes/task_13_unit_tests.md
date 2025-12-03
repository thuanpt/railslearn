# Task 13: Unit Tests (Minitest)

**Ngày hoàn thành:** 03/12/2025  
**Mục tiêu:** Viết Unit Tests cho Models sử dụng Minitest (framework mặc định của Rails).

---

## 📚 Kiến thức đã học

### 1. Minitest Framework

Rails sử dụng Minitest làm testing framework mặc định.
- **Test Case**: Class kế thừa từ `ActiveSupport::TestCase`.
- **Assertions**: Các method để kiểm tra kết quả (ví dụ: `assert`, `assert_not`, `assert_equal`).
- **Fixtures**: Dữ liệu mẫu (sample data) được định nghĩa trong file YAML (`test/fixtures/*.yml`).

### 2. Model Testing

Mục tiêu chính của Model Testing là kiểm tra:
- **Validations**: Đảm bảo dữ liệu không hợp lệ không được lưu.
- **Associations**: Đảm bảo quan hệ giữa các models hoạt động đúng.
- **Custom Logic**: Kiểm tra các method tự viết, scopes, enums.

### 3. Fixtures

Fixtures giúp tạo dữ liệu mẫu nhanh chóng và tự động load vào test database trước khi chạy test.
```yaml
# test/fixtures/users.yml
one:
  name: User One
  email: one@example.com
```
Trong test, gọi fixture bằng `users(:one)`.

---

## 💻 Code đã viết

### 1. Fixtures
- Cập nhật `users.yml`, `categories.yml`, `articles.yml` với dữ liệu hợp lệ.

### 2. Tests
- `UserTest`: Kiểm tra presence, uniqueness, format của email; độ dài password.
- `CategoryTest`: Kiểm tra presence, uniqueness, length của name.
- `ArticleTest`: Kiểm tra presence, length của title/body; associations (user, category); enum status.

---

## 🔑 Khái niệm quan trọng

### 1. `setup` method
Chạy trước mỗi test case. Dùng để khởi tạo dữ liệu chung.
```ruby
def setup
  @user = User.new(...)
end
```

### 2. `assert` vs `assert_not`
- `assert condition`: Test pass nếu condition là true.
- `assert_not condition`: Test pass nếu condition là false.

---

## ✅ Checklist hoàn thành

- [x] Update Fixtures
- [x] User Model Tests
- [x] Category Model Tests
- [x] Article Model Tests
- [x] Run Tests (`bin/rails test:models`)

---

## 🎯 Kết quả Verification

Lệnh `bin/rails test:models` đã chạy thành công với kết quả:
```
20 runs, 28 assertions, 0 failures, 0 errors, 0 skips
```
Tất cả các validations và logic quan trọng của Models đã được kiểm chứng.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Testing Rails Applications](https://guides.rubyonrails.org/testing.html)
- [Minitest Documentation](https://github.com/minitest/minitest)

---

## ➡️ Tiếp theo

Task 14: Integration Tests (Sắp tới)
