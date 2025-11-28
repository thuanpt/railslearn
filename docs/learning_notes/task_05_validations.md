# Task 5: Model Validations (Custom & Advanced)

**Ngày hoàn thành:** 28/11/2025  
**Mục tiêu:** Nâng cao khả năng kiểm soát dữ liệu với Custom Validations và Callbacks.

---

## 📚 Kiến thức đã học

### 1. Custom Validation Methods

Khi built-in validations không đủ, ta có thể viết method riêng để kiểm tra.

```ruby
validate :no_clickbait_keywords

def no_clickbait_keywords
  if title.match?(/Shocking|Secret/i)
    errors.add(:title, "is clickbait")
  end
end
```

### 2. Custom Validator Classes

Tách logic validation ra class riêng để tái sử dụng cho nhiều models.

```ruby
# app/validators/forbidden_words_validator.rb
class ForbiddenWordsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.include?("spam")
      record.errors.add(attribute, "contains forbidden words")
    end
  end
end
```

**Sử dụng:**
```ruby
validates :body, forbidden_words: { words: ['spam'] }
```

### 3. Conditional Validations

Chỉ validate khi thỏa mãn điều kiện nhất định.

```ruby
validates :published_at, presence: true, if: :published?
```

### 4. Callbacks

Callbacks là các methods chạy tại các thời điểm nhất định trong vòng đời của object (create, save, update, destroy).

```ruby
before_save :normalize_name

def normalize_name
  self.name = name.titleize
end
```

---

## 💻 Code đã viết

### 1. ForbiddenWordsValidator
**File:** `app/validators/forbidden_words_validator.rb`
- Class validator tái sử dụng để chặn các từ khóa cấm.

### 2. Article Model Updates
**File:** `app/models/article.rb`
- `validate :no_clickbait_keywords`: Chặn tiêu đề giật gân.
- `validates :body, forbidden_words: ...`: Áp dụng validator class.
- `validates :published_at, ... if: :published?`: Conditional validation.

### 3. Category Model Updates
**File:** `app/models/category.rb`
- `before_save :normalize_name`: Tự động viết hoa chữ cái đầu cho tên category.

---

## 🔑 Khái niệm quan trọng

### 1. `validate` vs `validates`
- `validates`: Dùng cho built-in validators hoặc custom validator classes.
- `validate`: Dùng cho custom validation methods định nghĩa trong model.

### 2. `errors.add`
Thêm thông báo lỗi vào object. Nếu `errors` không rỗng, object sẽ không valid.

### 3. Callback Order
Hiểu thứ tự chạy callback (ví dụ: `before_validation`, `after_validation`, `before_save`, `after_save`) là rất quan trọng để tránh bug.

---

## ✅ Checklist hoàn thành

- [x] Tạo `ForbiddenWordsValidator`
- [x] Thêm custom method `no_clickbait_keywords`
- [x] Thêm conditional validation cho `published_at`
- [x] Thêm callback `normalize_name` cho Category
- [x] Verify bằng script

---

## 🎯 Kết quả Verification

Script `verify_task_5.rb` đã chạy thành công:
1. ✅ **Clickbait**: Chặn tiêu đề "Top 10 Secrets"
2. ✅ **Spam**: Chặn body chứa "spam"
3. ✅ **Conditional**: Bắt buộc có `published_at` khi published
4. ✅ **Callback**: Category "ruby on rails" -> "Ruby On Rails"

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html#performing-custom-validations)
- [Rails Guides - Active Record Callbacks](https://guides.rubyonrails.org/active_record_callbacks.html)

---

## ➡️ Tiếp theo

Task 6: Active Record Queries (Advanced Querying)
