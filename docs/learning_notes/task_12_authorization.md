# Task 12: Authorization (Resource Ownership)

**Ngày hoàn thành:** 03/12/2025  
**Mục tiêu:** Phân quyền dựa trên sở hữu (Resource Ownership) - Chỉ tác giả mới được sửa/xóa bài viết của mình.

---

## 📚 Kiến thức đã học

### 1. Resource Ownership

Đây là mô hình phân quyền đơn giản nhất:
- Mỗi resource (Article) thuộc về một User (`belongs_to :user`).
- User có nhiều resource (`has_many :articles`).

### 2. Authorization Logic

Logic kiểm tra quyền thường nằm ở:
- **Controller**: Chặn các action thay đổi dữ liệu (edit, update, destroy) nếu không phải chủ sở hữu.
- **View**: Ẩn các nút bấm (Edit, Delete) để cải thiện UX.

### 3. Controller Filters

Sử dụng `before_action` để tái sử dụng logic kiểm tra quyền.

```ruby
before_action :require_user, except: [:index, :show]
before_action :require_same_user, only: [:edit, :update, :destroy]
```

---

## 💻 Code đã viết

### 1. Database & Models
- Migration: Thêm `user_id` vào bảng `articles`.
- Model: Setup association `User <-> Article`.

### 2. Controller
- `ArticlesController`:
    - Gán `current_user` khi tạo bài viết.
    - Method `require_same_user`: Redirect nếu `current_user != @article.user`.

### 3. Views
- `show.html.erb`: Chỉ hiển thị nút Edit/Delete nếu `current_user == @article.user`.
- `index.html.erb`: Hiển thị tên tác giả bài viết.

---

## 🔑 Khái niệm quan trọng

### 1. `dependent: :destroy`
Khi xóa User, tất cả Articles của User đó cũng sẽ bị xóa theo để tránh dữ liệu rác (orphan records).

### 2. `&.` (Safe Navigation Operator)
Dùng để tránh lỗi `NoMethodError` khi gọi method trên object có thể là `nil`.
Ví dụ: `article.user&.name` (nếu user nil thì trả về nil thay vì lỗi).

---

## ✅ Checklist hoàn thành

- [x] Add `user_id` to Articles
- [x] Setup Associations
- [x] Controller Authorization
- [x] View Authorization
- [x] Verify Logic (Script & Browser)

---

## 🎯 Kết quả Verification

1.  **Script**: `verify_task_12.rb` xác nhận User A sửa được bài của mình, User B thì không.
2.  **Browser**:
    - User A thấy nút Edit/Delete.
    - User B không thấy nút Edit/Delete và bị chặn khi cố truy cập URL edit.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Association Basics](https://guides.rubyonrails.org/association_basics.html)
- [Pundit Gem](https://github.com/varvet/pundit) (Giải pháp Authorization nâng cao cho tương lai)

---

## ➡️ Tiếp theo

**Phase 5: Testing** (Task 13: Unit Tests)
