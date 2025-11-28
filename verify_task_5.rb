puts "🔍 Verifying Model Validations..."

# 1. Test Clickbait Validation
puts "\n1. Testing Clickbait Validation:"
clickbait_article = Article.new(title: "Top 10 Secrets", body: "Valid body content here")
if clickbait_article.valid?
  puts "❌ Failed: Clickbait title should be invalid"
else
  puts "✅ Success: Clickbait detected"
  puts "   Errors: #{clickbait_article.errors[:title].join(', ')}"
end

# 2. Test Forbidden Words Validator
puts "\n2. Testing Forbidden Words:"
spam_article = Article.new(title: "Valid Title Here", body: "This contains spam content")
if spam_article.valid?
  puts "❌ Failed: Spam body should be invalid"
else
  puts "✅ Success: Forbidden words detected"
  puts "   Errors: #{spam_article.errors[:body].join(', ')}"
end

# 3. Test Conditional Validation
puts "\n3. Testing Conditional Validation (published_at):"
# Case A: Draft (should be valid without published_at)
draft = Article.new(title: "Draft Article", body: "Valid content", status: :draft)
if draft.valid?
  puts "✅ Success: Draft is valid without published_at"
else
  puts "❌ Failed: Draft should be valid. Errors: #{draft.errors.full_messages}"
end

# Case B: Published (should be invalid without published_at)
published = Article.new(title: "Published Article", body: "Valid content", status: :published)
if published.valid?
  puts "❌ Failed: Published article must have published_at"
else
  puts "✅ Success: Missing published_at detected for published article"
end

# 4. Test Category Callback
puts "\n4. Testing Category Callback:"
category = Category.create(name: "ruby on rails")
if category.name == "Ruby On Rails"
  puts "✅ Success: Category name normalized to '#{category.name}'"
else
  puts "❌ Failed: Category name not normalized. Got: '#{category.name}'"
end
