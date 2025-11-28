puts "🔍 Verifying Associations..."

# 1. Test Many-to-Many (Tags)
puts "\n1. Testing Many-to-Many (Tags):"
article = Article.find_by(title: "Bắt Đầu Với Ruby on Rails")
puts "Article: #{article.title}"
puts "Tags: #{article.tags.map(&:name).join(', ')}"

if article.tags.count == 3
  puts "✅ Success: Article has correct number of tags"
else
  puts "❌ Failed: Expected 3 tags, got #{article.tags.count}"
end

tag = Tag.find_by(name: "Web Development")
puts "Tag: #{tag.name}"
puts "Articles count: #{tag.articles.count}"
if tag.articles.count >= 2
  puts "✅ Success: Tag belongs to multiple articles"
else
  puts "❌ Failed: Tag should belong to at least 2 articles"
end

# 2. Test Polymorphic (Comments)
puts "\n2. Testing Polymorphic (Comments):"
puts "Article comments count: #{article.comments.count}"
if article.comments.any?
  puts "✅ Success: Article has comments"
  puts "   First comment: #{article.comments.first.body}"
else
  puts "❌ Failed: Article should have comments"
end

# 3. Test Dependent Destroy
puts "\n3. Testing Dependent Destroy:"
temp_article = Article.create!(
  title: "Temp Article", 
  body: "To be deleted", 
  status: :draft,
  category: Category.first
)
temp_article.tags << Tag.first
temp_article.comments.create!(body: "Temp comment")

article_id = temp_article.id
comment_id = temp_article.comments.first.id
tagging_count_before = Tagging.count

puts "Deleting article..."
temp_article.destroy

if Comment.exists?(comment_id)
  puts "❌ Failed: Comment should be deleted"
else
  puts "✅ Success: Comment deleted"
end

if Tagging.count < tagging_count_before
  puts "✅ Success: Tagging deleted"
else
  puts "❌ Failed: Tagging should be deleted"
end

if Tag.exists? # Tags should NOT be deleted
  puts "✅ Success: Tags preserved (as expected)"
end
