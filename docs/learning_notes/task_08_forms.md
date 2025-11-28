# Task 8: Forms & User Input (Nested Forms, Virtual Attributes)

**Ngày hoàn thành:** 28/11/2025  
**Mục tiêu:** Xây dựng giao diện nhập liệu phức tạp với Nested Resources và Virtual Attributes.

---

## 📚 Kiến thức đã học

### 1. Virtual Attributes (`tag_list`)

Virtual attributes là các thuộc tính không có cột tương ứng trong database nhưng được xử lý trong model như một attribute thật.

**Use Case:** Nhập tags dưới dạng chuỗi "ruby, rails" thay vì phải tạo từng record Tag thủ công.

```ruby
# app/models/article.rb
def tag_list
  tags.map(&:name).join(", ")
end

def tag_list=(names)
  self.tags = names.split(",").map do |n|
    Tag.where(name: n.strip).first_or_create!
  end
end
```

### 2. Nested Resources

Tạo routes con lồng trong routes cha để thể hiện quan hệ phụ thuộc.

```ruby
# config/routes.rb
resources :articles do
  resources :comments
end
```

**Routes tạo ra:**
- `POST /articles/:article_id/comments` (create)
- `DELETE /articles/:article_id/comments/:id` (destroy)

### 3. Nested Forms

Form để tạo resource con ngay trong trang của resource cha.

```erb
<!-- app/views/comments/_form.html.erb -->
<%= form_with(model: [ @article, @article.comments.build ]) do |form| %>
  <!-- fields -->
<% end %>
```
Lưu ý mảng `[ @article, ... ]` để Rails biết url cần post tới là nested route.

### 4. Form Partials

Tách form ra partial (`_form.html.erb`) để tái sử dụng và giữ view gọn gàng.

---

## 💻 Code đã viết

### 1. Article Tagging
- **Model**: Thêm `tag_list` getter/setter.
- **Controller**: Permit `tag_list` param.
- **View**: Thêm text field nhập tags vào form article.

### 2. Comments System
- **Routes**: Nested comments under articles.
- **Controller**: `CommentsController` với `create` và `destroy`.
- **Views**:
    - `_form.html.erb`: Form nhập comment.
    - `_comment.html.erb`: Hiển thị một comment.
    - `show.html.erb`: Tích hợp hiển thị và form comment.

---

## 🔑 Khái niệm quan trọng

### 1. `form_with model: [...]`
Cú pháp quan trọng để làm việc với nested resources.

### 2. `first_or_create!`
Tìm record, nếu không thấy thì tạo mới. Rất hữu ích cho Tags.

### 3. `turbo_confirm`
Hiển thị popup xác nhận trước khi xóa (đã dùng cho delete comment).

---

## ✅ Checklist hoàn thành

- [x] Implement `tag_list` virtual attribute
- [x] Update Article form với Tag input
- [x] Config Nested Routes cho Comments
- [x] Tạo CommentsController
- [x] Tạo Views cho Comments
- [x] Verify bằng script

---

## 🎯 Kết quả Verification

Script `verify_task_8.rb` đã chạy thành công:
1. ✅ **Tags**: Nhập chuỗi "ruby, forms" -> Tạo được 2 tags và gắn vào article.
2. ✅ **Comments**: Tạo được comment cho article và xóa thành công.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Form Helpers](https://guides.rubyonrails.org/form_helpers.html)
- [Rails Guides - Routing (Nested Resources)](https://guides.rubyonrails.org/routing.html#nested-resources)

---

## ➡️ Tiếp theo

Task 9: Strong Parameters (Security Deep Dive)
