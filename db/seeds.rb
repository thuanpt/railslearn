# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Đang seed data..."

# 1. Tạo Categories
puts "Creating categories..."
tech = Category.find_or_create_by!(name: "Technology")
prog = Category.find_or_create_by!(name: "Programming")
life = Category.find_or_create_by!(name: "Lifestyle")

# 2. Tạo Tags
puts "Creating tags..."
ruby_tag = Tag.find_or_create_by!(name: "Ruby")
rails_tag = Tag.find_or_create_by!(name: "Rails")
web_tag = Tag.find_or_create_by!(name: "Web Development")
career_tag = Tag.find_or_create_by!(name: "Career")

# 3. Tạo Articles
puts "Creating articles..."

# Xóa articles cũ để tránh duplicate
Article.destroy_all

a1 = Article.create!(
  title: "Bắt Đầu Với Ruby on Rails",
  body: "Ruby on Rails là một web framework mạnh mẽ...",
  published: true,
  published_at: Time.current,
  status: :published,
  view_count: 150,
  category: tech
)
a1.tags << [ruby_tag, rails_tag, web_tag]
a1.comments.create!(body: "Bài viết rất hay! Cảm ơn tác giả.")
a1.comments.create!(body: "Mình đang học Rails, bài này rất hữu ích.")

a2 = Article.create!(
  title: "MVC Architecture Explained",
  body: "Model-View-Controller (MVC) là một design pattern...",
  published: true,
  published_at: 1.day.ago,
  status: :published,
  view_count: 89,
  category: prog
)
a2.tags << [web_tag]
a2.comments.create!(body: "Giải thích dễ hiểu quá.")

a3 = Article.create!(
  title: "Work Life Balance",
  body: "Cân bằng giữa công việc và cuộc sống...",
  published: true,
  published_at: 3.days.ago,
  status: :published,
  view_count: 50,
  category: life
)
a3.tags << [career_tag]

puts "✅ Seed data thành công!"
puts "- Articles: #{Article.count}"
puts "- Categories: #{Category.count}"
puts "- Tags: #{Tag.count}"
puts "- Comments: #{Comment.count}"
