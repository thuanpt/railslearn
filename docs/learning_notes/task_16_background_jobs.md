# Task 16: Background Jobs (Active Job)

**Ngày hoàn thành:** 04/12/2025  
**Mục tiêu:** Sử dụng Active Job để xử lý các tác vụ nền (Background Processing).

---

## 📚 Kiến thức đã học

### 1. Active Job

Active Job là framework của Rails để khai báo các jobs và chạy chúng trên nhiều backend khác nhau (Sidekiq, Resque, Delayed Job, hoặc Async mặc định).

### 2. Synchronous vs Asynchronous

- **Synchronous (`perform_now`)**: Chạy ngay lập tức trong request hiện tại. User phải chờ job chạy xong mới nhận được phản hồi.
- **Asynchronous (`perform_later`)**: Đẩy job vào hàng đợi (queue). Một process khác (worker) sẽ lấy job ra và chạy. User nhận phản hồi ngay lập tức.

### 3. Job Structure

```ruby
class MyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Logic xử lý nặng (gửi mail, resize ảnh...)
  end
end
```

---

## 💻 Code đã viết

### 1. Job
- `WelcomeEmailJob`: Giả lập việc gửi email với `sleep 5`.

### 2. Controller
- `UsersController`: Gọi `WelcomeEmailJob.perform_later(@user)` sau khi tạo user thành công.

---

## 🔑 Khái niệm quan trọng

### 1. Queue Adapter
Rails 8 mặc định dùng adapter `:async` (Async Adapter). Nó chạy job trong một thread pool cùng process với web server (Puma).
- **Ưu điểm**: Không cần cài đặt gì thêm (Redis/Sidekiq).
- **Nhược điểm**: Nếu restart server, các job đang chờ trong RAM sẽ bị mất. Không phù hợp cho production quy mô lớn.

### 2. GlobalID
Active Job sử dụng GlobalID để serialize/deserialize các object Active Record.
Khi bạn truyền `@user` vào `perform_later(@user)`, Rails thực chất chỉ lưu `gid://myapp/User/1`. Khi job chạy, nó tự động tìm lại User ID 1 từ database.

---

## ✅ Checklist hoàn thành

- [x] Generate Job (`WelcomeEmailJob`)
- [x] Implement `perform` logic
- [x] Enqueue in Controller
- [x] Verify Async Execution (Script)

---

## 🎯 Kết quả Verification

Script `verify_task_16.rb` đã xác nhận:
1.  **Synchronous**: Mất ~5s để chạy xong (mô phỏng delay).
2.  **Asynchronous**: Chỉ mất < 0.01s để enqueue (trả về ngay lập tức).

---

## 🔗 Tài liệu tham khảo

- [Rails Guides - Active Job Basics](https://guides.rubyonrails.org/active_job_basics.html)

---

## ➡️ Tiếp theo

Task 17: Caching & Performance (Sắp tới)
