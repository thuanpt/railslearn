# Task 16b: Real Emails & Sidekiq

**Ngày hoàn thành:** 05/12/2025  
**Mục tiêu:** Cấu hình gửi email thật (qua Letter Opener) và sử dụng Sidekiq để xử lý Background Jobs.

---

## 📚 Kiến thức đã học

### 1. Action Mailer & Letter Opener

- **Action Mailer**: Framework gửi email của Rails.
- **Letter Opener**: Gem giúp xem email gửi đi ngay trong trình duyệt (môi trường development) mà không cần SMTP server thực.

### 2. Sidekiq & Redis

- **Sidekiq**: Background Job framework mạnh mẽ, sử dụng đa luồng (multithreading) để xử lý job nhanh chóng.
- **Redis**: In-memory data structure store, được Sidekiq dùng để lưu trữ hàng đợi (queue) các job cần xử lý.

**So sánh:**
- `Async Adapter` (Mặc định): Lưu job trong RAM của web server. Mất job khi restart server.
- `Sidekiq`: Lưu job trong Redis. Bền vững hơn, có giao diện quản lý, xử lý lỗi tốt hơn.

---

## 💻 Code đã viết

### 1. Configuration
- `config/environments/development.rb`:
    - `delivery_method = :letter_opener`
    - `queue_adapter = :sidekiq`
- `config/sidekiq.yml`: Cấu hình queue.
- `config/initializers/sidekiq.rb`: Cấu hình kết nối Redis.

### 2. Mailer
- `UserMailer`: Class định nghĩa email.
- `welcome_email.html.erb`: Template nội dung email.

### 3. Job
- `WelcomeEmailJob`: Gọi `UserMailer` để gửi email.

---

## ⚠️ Yêu cầu hệ thống (Redis)

Để Sidekiq hoạt động, bạn cần cài đặt và chạy **Redis**:

**MacOS (Homebrew):**
```bash
brew install redis
brew services start redis
```

**Ubuntu:**
```bash
sudo apt-get install redis-server
sudo systemctl start redis
```

---

## ✅ Checklist hoàn thành

- [x] Add `sidekiq` & `letter_opener` Gems
- [x] Configure Action Mailer
- [x] Create `UserMailer`
- [x] Configure Sidekiq
- [ ] Verify Sidekiq (Requires Redis)

---

## 🎯 Hướng dẫn chạy thử

1.  Đảm bảo Redis đang chạy.
2.  Mở terminal mới, chạy Sidekiq:
    ```bash
    bundle exec sidekiq
    ```
3.  Đăng ký user mới trên web.
4.  Sidekiq sẽ xử lý job và Letter Opener sẽ bật tab trình duyệt hiển thị email.

---

## 🔗 Tài liệu tham khảo

- [Sidekiq Wiki](https://github.com/sidekiq/sidekiq/wiki)
- [Rails Guides - Action Mailer Basics](https://guides.rubyonrails.org/action_mailer_basics.html)

---

## ➡️ Tiếp theo

Task 17b: Advanced Performance (Sắp tới)
