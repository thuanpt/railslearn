# Task 7: Associations (Many-to-Many, Polymorphic)

**Ngày hoàn thành:** 28/11/2025  
**Mục tiêu:** Master các quan hệ phức tạp trong Active Record: Many-to-Many và Polymorphic.

---

## 📚 Kiến thức đã học

### 1. Many-to-Many (Has Many Through)

Dùng để liên kết 2 models với nhau thông qua một bảng trung gian (Join Table).

**Ví dụ:** Article <-> Tag
- Article có nhiều Tags
- Tag có nhiều Articles
- Bảng trung gian: `taggings`

**Code:**
```ruby
# app/models/article.rb
has_many :taggings, dependent: :destroy
has_many :tags, through: :taggings

# app/models/tag.rb
has_many :taggings, dependent: :destroy
has_many :articles, through: :taggings

# app/models/tagging.rb
belongs_to :article
belongs_to :tag
```

### 2. Polymorphic Associations

Cho phép một model thuộc về nhiều loại model khác nhau chỉ với một association.

**Ví dụ:** Comment
- Comment có thể thuộc về Article
- Comment có thể thuộc về Video, Photo, User... (sau này)

**Migration:**
```ruby
t.references :commentable, polymorphic: true
# Tạo ra 2 cột: commentable_id (integer) và commentable_type (string)
```

**Code:**
```ruby
# app/models/comment.rb
belongs_to :commentable, polymorphic: true

# app/models/article.rb
has_many :comments, as: :commentable
```

### 3. Association Options

- `dependent: :destroy`: Khi xóa object cha (Article), tự động xóa object con (Comments, Taggings) để tránh rác database.
- `optional: true`: Cho phép `belongs_to` có thể null (như trong Task 6 với Category).

---

## 💻 Code đã viết

### 1. Migrations
- `CreateTags`: Bảng tags
- `CreateTaggings`: Bảng trung gian (article_id, tag_id)
- `CreateComments`: Bảng comments (commentable_id, commentable_type)

### 2. Models
- **Article**: Thêm associations với Tags và Comments.
- **Tag**: Model mới.
- **Comment**: Model mới (Polymorphic).

### 3. Seeds
- Tạo sample Tags (Ruby, Rails...).
- Gán Tags cho Articles.
- Tạo Comments cho Articles.

---

## 🔑 Khái niệm quan trọng

### 1. Join Table
Bảng chứa Foreign Keys của 2 bảng khác để tạo quan hệ Many-to-Many.

### 2. `commentable_type`
Cột lưu tên Class của model cha (ví dụ: "Article"). Active Record dùng cột này để biết cần join với bảng nào.

### 3. `through`
Chỉ định model trung gian để đi xuyên qua.

---

## ✅ Checklist hoàn thành

- [x] Tạo migration Tags & Taggings
- [x] Tạo migration Comments (Polymorphic)
- [x] Update Models associations
- [x] Update seeds data
- [x] Verify Many-to-Many
- [x] Verify Polymorphic
- [x] Verify Dependent Destroy

---

## 🎯 Kết quả Verification

Script `verify_task_7.rb` đã chạy thành công:
1. ✅ **Tags**: Article có đúng 3 tags, Tag thuộc về 2 articles.
2. ✅ **Comments**: Article có comments, truy xuất được nội dung.
3. ✅ **Cleanup**: Xóa Article tự động xóa Comments và Taggings liên quan.

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Associations](https://guides.rubyonrails.org/association_basics.html)
- [Rails Guides - Polymorphic Associations](https://guides.rubyonrails.org/association_basics.html#polymorphic-associations)

---

## ➡️ Tiếp theo

Task 8: Forms & User Input (Nested Forms, Custom Builders)
