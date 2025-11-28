puts "🔍 Verifying Active Record Basics..."

# 1. Test Validations
puts "\n1. Testing Validations:"
invalid_article = Article.new(title: "Hi", body: "Short")
if invalid_article.valid?
  puts "❌ Failed: Invalid article should not be valid"
else
  puts "✅ Success: Invalid article detected"
  puts "   Errors: #{invalid_article.errors.full_messages.join(', ')}"
end

# 2. Test Enums
puts "\n2. Testing Enums:"
article = Article.new(title: "Enum Test Article", body: "This is a test body for enum", status: :published)
if article.published?
  puts "✅ Success: Enum status is working (published? returns true)"
else
  puts "❌ Failed: Enum status check failed"
end

# 3. Test Scopes
puts "\n3. Testing Scopes:"
recent_count = Article.recent.count
popular_count = Article.popular.count
puts "✅ Success: Scopes are executable"
puts "   Recent count: #{recent_count}"
puts "   Popular count: #{popular_count}"

# 4. Test Category
puts "\n4. Testing Category:"
category = Category.new(name: "Technology") # Duplicate name from seeds
if category.valid?
  puts "❌ Failed: Duplicate category name should not be valid"
else
  puts "✅ Success: Uniqueness validation working"
end
