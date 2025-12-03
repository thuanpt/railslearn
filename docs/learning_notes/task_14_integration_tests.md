# Task 14: Integration Tests (System Tests)

**Ngày hoàn thành:** 03/12/2025  
**Mục tiêu:** Viết System Tests để kiểm thử toàn bộ luồng người dùng (End-to-End Testing) sử dụng Capybara.

---

## 📚 Kiến thức đã học

### 1. System Testing

System Tests kiểm tra ứng dụng như một người dùng thực sự:
- Mở trình duyệt (thường là Headless Chrome).
- Tương tác với các phần tử trên trang (click, fill form).
- Kiểm tra nội dung hiển thị (assert text).

Rails sử dụng `Capybara` để điều khiển trình duyệt và `Selenium` (hoặc `Cuprite`) làm driver.

### 2. Capybara DSL

Các method phổ biến:
- `visit path`: Truy cập URL.
- `fill_in "Label", with: "Value"`: Điền form.
- `click_button "Button Name"`: Click nút submit.
- `click_link "Link Name"`: Click link.
- `assert_text "Content"`: Kiểm tra nội dung có xuất hiện không.
- `check "Checkbox Label"`: Chọn checkbox.
- `select "Option", from: "Select Label"`: Chọn dropdown.

### 3. Debugging System Tests

- **Screenshots**: Khi test fail, Rails tự động chụp màn hình và lưu vào `tmp/screenshots/`.
- **Ambiguous Match**: Lỗi phổ biến khi có nhiều phần tử cùng tên (ví dụ: nút "Login" và link "Login"). Giải quyết bằng cách dùng selector cụ thể hơn (`click_button` vs `click_link`).

---

## 💻 Code đã viết

### 1. Configuration
- `test/application_system_test_case.rb`: Cấu hình driver `:headless_chrome`.

### 2. Tests
- `AuthenticationTest`:
    - Test luồng Đăng ký (Sign Up) thành công.
- `ArticlesTest`:
    - Test luồng Đăng nhập -> Tạo bài viết mới.
    - Xử lý các trường input phức tạp (checkbox, select).

---

## 🔑 Khái niệm quan trọng

### 1. Headless Browser
Trình duyệt chạy ngầm không có giao diện (UI), giúp test chạy nhanh hơn và phù hợp với môi trường CI/CD.

### 2. Capybara Waiting
Capybara tự động chờ (mặc định 2s) cho đến khi phần tử xuất hiện. Điều này giúp xử lý các vấn đề về bất đồng bộ (AJAX/JavaScript) mà không cần `sleep`.

---

## ✅ Checklist hoàn thành

- [x] Configure System Test Driver
- [x] Authentication System Test (Sign Up)
- [x] Article System Test (Create Article)
- [x] Fix Ambiguous Selectors
- [x] Run Tests (`bin/rails test:system`)

---

## 🎯 Kết quả Verification

Lệnh `bin/rails test:system` đã chạy thành công với kết quả:
```
2 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```
Đã kiểm chứng được luồng người dùng quan trọng nhất của ứng dụng.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - System Testing](https://guides.rubyonrails.org/testing.html#system-testing)
- [Capybara Documentation](https://github.com/teamcapybara/capybara)

---

## ➡️ Tiếp theo

**Phase 6: Advanced Topics** (Task 15: API Development)
