# Rails Learning Notes 📚

Đây là nơi tổng kết tất cả những gì đã học trong quá trình học Ruby on Rails.

---

## 📋 Danh sách Tasks

### ✅ Đã hoàn thành

1. **[Task 1: MVC Pattern](task_01_mvc_pattern.md)**
   - Hiểu Model-View-Controller
   - Tạo Controller và Views
   - Cấu hình Routes
   - ERB Templates cơ bản
   - **Ngày hoàn thành:** 20/11/2025

2. **[Task 2: RESTful Routes & CRUD](task_02_restful_crud.md)**
   - RESTful architecture
   - 7 CRUD actions chuẩn
   - Resources routes
   - Form helpers
   - Strong parameters
   - **Ngày hoàn thành:** 25/11/2025

### 🔄 Đang học

3. **[Task 3: Views & ERB Templates](task_03_views_erb.md)**
   - Layouts & Partials
   - View Helpers
   - Asset Pipeline (CSS)
   - **Ngày hoàn thành:** 28/11/2025

### 🔄 Đang học

4. **Task 4: Active Record Basics** (Sắp bắt đầu)
   - Migrations chi tiết
   - Model methods
   - Query interface
   - Scopes

5. **Task 5: Model Validations**
   - Built-in validations
   - Custom validations
   - Error handling

6. **Task 6: Active Record Queries**
   - Find, where, order
   - Joins và includes
   - N+1 problem
   - Database optimization

7. **Task 7: Associations**
   - One-to-Many
   - Many-to-Many
   - Polymorphic associations

8. **Task 8: Forms & User Input**
   - Form builders
   - Nested forms
   - File uploads (Active Storage)

9. **Task 9: Strong Parameters**
   - Security best practices
   - Nested parameters
   - Arrays và hashes

10. **Task 10: File Uploads**
    - Active Storage setup
    - Image processing
    - Direct uploads

---

## 🎯 Mục tiêu học tập

- ✅ Hiểu cơ bản về Rails framework
- ✅ Xây dựng CRUD application
- ⏳ Master Active Record
- ⏳ Authentication & Authorization
- ⏳ Testing
- ⏳ API Development
- ⏳ Background Jobs
- ⏳ Deployment

---

## 📊 Tiến độ

```
[███████████████░░░░░] 30% - Đã hoàn thành 3/10 tasks cơ bản
```

---

## 🛠️ Project Demo

**Project:** Simple Blog Application  
**Repository:** `/Users/thuanpt/Projects/myapp`

**Features đã implement:**
- ✅ MVC structure
- ✅ Pages (Home, About, Contact)
- ✅ Articles CRUD
- ✅ RESTful routes
- ⏳ Validations
- ⏳ Associations (Comments)
- ⏳ Authentication
- ⏳ Authorization

---

## 📚 Tài liệu tham khảo

- [Rails Guides (Official)](https://guides.rubyonrails.org/)
- [Ruby Documentation](https://ruby-doc.org/)
- [Rails API Documentation](https://api.rubyonrails.org/)

---

## 💡 Tips & Tricks đã học

1. **Convention over Configuration**: Rails tự động tìm view dựa trên tên action
2. **DRY (Don't Repeat Yourself)**: Sử dụng partials để tránh duplicate code
3. **Resources routes**: Một dòng `resources :articles` tạo 7 routes
4. **Strong Parameters**: Luôn filter params để bảo mật
5. **Rails Console**: Tool tốt nhất để test code (`rails console`)
6. **Rails Routes**: Xem tất cả routes với `rails routes`

---

## 🐛 Common Issues & Solutions

### Issue 1: Database connection error
**Solution:** Check `config/database.yml` và chạy `rails db:create`

### Issue 2: Route not found
**Solution:** Chạy `rails routes` để xem routes đã định nghĩa

### Issue 3: Template missing
**Solution:** Kiểm tra tên file view phải trùng với action name

---

## 📝 Ghi chú quan trọng

- Luôn commit code sau mỗi task hoàn thành
- Test trên browser sau mỗi thay đổi
- Đọc Rails Guides khi gặp vấn đề
- Sử dụng Rails Console để debug
- Follow Rails conventions để code dễ maintain

---

**Last updated:** 25/11/2025  
**Next task:** Task 3 - Views & ERB Templates
