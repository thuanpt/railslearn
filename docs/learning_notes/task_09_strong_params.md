# Task 9: Strong Parameters (Security & Nested Attributes)

**Ngày hoàn thành:** 30/11/2025  
**Mục tiêu:** Hiểu sâu về cơ chế bảo mật Mass Assignment và xử lý Nested Attributes.

---

## 📚 Kiến thức đã học

### 1. Strong Parameters là gì?

Là cơ chế bảo mật của Rails (ở tầng Controller) để ngăn chặn **Mass Assignment Vulnerability**. Nó yêu cầu developer phải khai báo rõ ràng những attributes nào được phép update.

```ruby
# Chỉ cho phép title và body, loại bỏ các params khác (như admin: true, user_id: ...)
params.require(:article).permit(:title, :body)
```

### 2. Nested Attributes

Cho phép lưu record cha và các records con trong cùng một request.

**Model:**
```ruby
# app/models/article.rb
accepts_nested_attributes_for :comments, allow_destroy: true
```

**Controller:**
Cần permit một array of hashes cho nested attributes. Key phải có suffix `_attributes`.
```ruby
params.require(:article).permit(..., comments_attributes: [:id, :body, :_destroy])
```
*   `:id`: Để Rails biết đang update record nào (nếu thiếu sẽ tạo mới).
*   `:_destroy`: Attribute đặc biệt để xóa record con (nếu `allow_destroy: true`).

### 3. Mass Assignment Protection

Nếu không dùng Strong Params, hacker có thể gửi thêm params độc hại:
```ruby
# Hacker gửi: { article: { title: "Hacked", admin: true } }
User.create(params[:user]) # Nguy hiểm!
```

Với Strong Params:
```ruby
# An toàn, admin bị lọc bỏ
User.create(user_params) 
```

---

## 💻 Code đã viết

### 1. Nested Attributes Implementation
- **Model**: `accepts_nested_attributes_for :comments` trong Article.
- **Controller**: Permit `comments_attributes` trong `ArticlesController`.
- **View**: Dùng `fields_for :comments` trong form Article để hiển thị input cho comments.

### 2. Security Demo
**File:** `mass_assignment_demo.rb`
- Demo việc cố tình gửi `created_at` (protected attribute) và thấy Strong Params lọc bỏ nó thành công.

---

## 🔑 Khái niệm quan trọng

### 1. `require` vs `permit`
- `require`: Đảm bảo key chính (ví dụ `:article`) phải tồn tại.
- `permit`: Danh sách các attributes được phép (whitelist).

### 2. `fields_for`
Helper để tạo form fields cho object liên quan (nested object) mà không cần tạo form tag mới.

### 3. `allow_destroy: true`
Cho phép xóa record con bằng cách gửi param `_destroy: '1'`.

---

## ✅ Checklist hoàn thành

- [x] Config `accepts_nested_attributes_for`
- [x] Update Strong Params cho Nested Attributes
- [x] Update Form với `fields_for`
- [x] Demo Mass Assignment Protection
- [x] Verify Nested Create/Update/Destroy

---

## 🎯 Kết quả Verification

1.  **Security**: Script `mass_assignment_demo.rb` xác nhận `created_at` bị chặn khi đi qua Strong Params.
2.  **Nested Attributes**: Script `verify_task_9.rb` xác nhận có thể tạo Article kèm Comments, và update/xóa Comment thông qua update Article.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Strong Parameters](https://guides.rubyonrails.org/action_controller_overview.html#strong-parameters)
- [Rails API - accepts_nested_attributes_for](https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)

---

## ➡️ Tiếp theo

Task 10: File Uploads (Active Storage)
