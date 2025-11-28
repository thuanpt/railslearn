puts "🔍 Verifying Forms & User Input..."

# 1. Test Tag List (Virtual Attribute)
puts "\n1. Testing Tag List:"
article = Article.new(
  title: "Tag List Test",
  body: "Testing virtual attribute",
  published: true,
  published_at: Time.current,
  status: :published,
  category: Category.first
)
article.tag_list = "ruby, forms, input"
article.save!

puts "Article created with tags: #{article.tag_list}"
if article.tags.count == 3 && article.tags.exists?(name: "forms")
  puts "✅ Success: Tags created via virtual attribute"
else
  puts "❌ Failed: Tags not created correctly"
end

# 2. Test Comments (Nested Resource)
puts "\n2. Testing Comments:"
comment = article.comments.create!(body: "Test comment from script")
puts "Comment created: #{comment.body}"

if article.comments.count == 1
  puts "✅ Success: Comment associated with article"
else
  puts "❌ Failed: Comment not associated"
end

# 3. Test Comment Deletion
puts "\n3. Testing Comment Deletion:"
comment.destroy
if article.comments.count == 0
  puts "✅ Success: Comment deleted"
else
  puts "❌ Failed: Comment not deleted"
end
