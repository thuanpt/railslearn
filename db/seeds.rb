# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Tạo sample articles
puts "Đang tạo sample articles..."

Article.create!([
  {
    title: "Bắt Đầu Với Ruby on Rails",
    body: "Ruby on Rails là một web framework mạnh mẽ được xây dựng trên ngôn ngữ Ruby. Rails theo triết lý 'Convention over Configuration' giúp developers tập trung vào business logic thay vì cấu hình.\n\nRails bao gồm nhiều thành phần:\n- Active Record: ORM để tương tác với database\n- Action Controller: xử lý HTTP requests\n- Action View: render templates\n- Active Job: background jobs\n\nVới Rails, bạn có thể xây dựng ứng dụng web nhanh chóng và hiệu quả.",
    published: true
  },
  {
    title: "MVC Architecture Explained",
    body: "Model-View-Controller (MVC) là một design pattern phổ biến trong web development.\n\nModel: Quản lý data và business logic\nView: Hiển thị giao diện người dùng\nController: Điều khiển flow của application\n\nRails implements MVC rất tốt và giúp code của bạn organized và dễ maintain.",
    published: true
  },
  {
    title: "RESTful Routes trong Rails",
    body: "REST (Representational State Transfer) là một architectural style cho web services.\n\nRails cung cấp 7 RESTful actions:\n1. index - GET /resources\n2. show - GET /resources/:id\n3. new - GET /resources/new\n4. create - POST /resources\n5. edit - GET /resources/:id/edit\n6. update - PATCH/PUT /resources/:id\n7. destroy - DELETE /resources/:id\n\nSử dụng 'resources :articles' trong routes.rb sẽ tự động tạo tất cả routes này.",
    published: true
  },
  {
    title: "Active Record Basics",
    body: "Active Record là ORM (Object-Relational Mapping) của Rails.\n\nNó cho phép bạn:\n- Tương tác với database không cần viết SQL\n- Validate data trước khi lưu\n- Tạo associations giữa các models\n- Query data dễ dàng\n\nVí dụ: Article.where(published: true).order(created_at: :desc)",
    published: false
  },
  {
    title: "Rails Console - Developer's Best Friend",
    body: "Rails Console là công cụ không thể thiếu khi develop Rails apps.\n\nMở console: rails console hoặc rails c\n\nBạn có thể:\n- Test models và queries\n- Debug issues\n- Thao tác với database\n- Test Ruby code\n\nVí dụ:\nArticle.count\nArticle.first\nArticle.create(title: 'Test', body: 'Content')",
    published: false
  }
])

puts "✅ Đã tạo #{Article.count} articles!"

