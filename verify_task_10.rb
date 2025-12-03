puts "🔍 Verifying File Uploads (Active Storage)..."

# 1. Create Article with Attachment
puts "\n1. Creating Article with Cover Image:"
article = Article.new(
  title: "Active Storage Test",
  body: "Testing file upload",
  published: true,
  category: Category.first
)

# Attach file
article.cover_image.attach(
  io: File.open(Rails.root.join("test_image.jpg")),
  filename: "test_image.jpg",
  content_type: "image/jpeg"
)

article.save!

puts "Article created: #{article.title}"
puts "Attached? #{article.cover_image.attached?}"

if article.cover_image.attached?
  puts "✅ Success: Cover image attached"
  puts "Filename: #{article.cover_image.filename}"
else
  puts "❌ Failed: Cover image not attached"
end

# 2. Verify Blob
puts "\n2. Verifying Blob:"
blob = article.cover_image.blob
puts "Blob ID: #{blob.id}"
puts "Content Type: #{blob.content_type}"
puts "Byte Size: #{blob.byte_size}"

if blob.present?
  puts "✅ Success: Blob created in database"
else
  puts "❌ Failed: Blob missing"
end
