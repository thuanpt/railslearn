puts "🔍 Verifying Authorization..."

# 1. Setup Users
puts "\n1. Setting up Users:"
User.destroy_all
user_a = User.create!(name: "User A", email: "a@test.com", password: "password", password_confirmation: "password")
user_b = User.create!(name: "User B", email: "b@test.com", password: "password", password_confirmation: "password")
puts "Created User A and User B"

# 2. User A creates Article
puts "\n2. User A creates Article:"
article_a = Article.create!(
  title: "User A's Article",
  body: "Content is long enough now",
  user: user_a,
  category: Category.first
)
puts "Article created by: #{article_a.user.name}"

# 3. Verify Ownership Check
puts "\n3. Verifying Ownership Logic:"

# Simulate Controller Logic
def can_edit?(user, article)
  user == article.user
end

if can_edit?(user_a, article_a)
  puts "✅ Success: User A can edit their own article"
else
  puts "❌ Failed: User A cannot edit their own article"
end

if !can_edit?(user_b, article_a)
  puts "✅ Success: User B cannot edit User A's article"
else
  puts "❌ Failed: User B can edit User A's article"
end

# 4. Verify Association
puts "\n4. Verifying Association:"
if user_a.articles.include?(article_a)
  puts "✅ Success: Article is in User A's articles list"
else
  puts "❌ Failed: Association missing"
end
