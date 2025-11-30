puts "🔍 Verifying Nested Attributes..."

# 1. Create Article with Nested Comments
puts "\n1. Creating Article with Nested Comments:"
article_params = {
  title: "Nested Attributes Test",
  body: "Testing accepts_nested_attributes_for",
  published: true,
  category: Category.first,
  comments_attributes: [
    { body: "Nested comment 1" },
    { body: "Nested comment 2" }
  ]
}

article = Article.create!(article_params)
puts "Article created: #{article.title}"
puts "Comments count: #{article.comments.count}"

if article.comments.count == 2
  puts "✅ Success: Nested comments created"
else
  puts "❌ Failed: Expected 2 comments, got #{article.comments.count}"
end

# 2. Update Article and Delete Comment via Nested Attributes
puts "\n2. Updating Article and Deleting Comment:"
comment_to_delete = article.comments.first
comment_to_keep = article.comments.last

update_params = {
  title: "Updated Title",
  comments_attributes: {
    "0" => { id: comment_to_delete.id, _destroy: "1" }, # Mark for destruction
    "1" => { id: comment_to_keep.id, body: "Updated comment body" } # Update existing
  }
}

article.update!(update_params)

puts "Article title: #{article.title}"
puts "Comments count: #{article.comments.count}"
puts "Remaining comment body: #{article.comments.first.body}"

if article.comments.count == 1 && article.comments.first.body == "Updated comment body"
  puts "✅ Success: Comment deleted and updated via nested attributes"
else
  puts "❌ Failed: Nested update/destroy failed"
end
