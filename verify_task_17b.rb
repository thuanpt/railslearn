puts "🔍 Verifying Advanced Performance..."

# 1. Verify Database Indexes
puts "\n1. Checking Database Indexes:"
indexes = ActiveRecord::Base.connection.indexes(:articles).map(&:columns)
if indexes.include?(["user_id"]) && indexes.include?(["category_id"])
  puts "✅ Success: Articles table has indexes on user_id and category_id."
else
  puts "❌ Failed: Missing indexes on articles table. Found: #{indexes}"
end

comment_indexes = ActiveRecord::Base.connection.indexes(:comments).map(&:columns)
if comment_indexes.include?(["commentable_type", "commentable_id"])
  puts "✅ Success: Comments table has polymorphic index on commentable."
else
  puts "❌ Failed: Missing polymorphic index on comments table. Found: #{comment_indexes}"
end

# 2. Verify Redis Cache
puts "\n2. Checking Redis Cache:"
begin
  puts "   Connecting to Redis at #{Rails.configuration.cache_store.inspect}..."
  write_result = Rails.cache.write("test_key", "Redis is working!")
  puts "   Write Result: #{write_result.inspect}"
  
  value = Rails.cache.read("test_key")
  
  if value == "Redis is working!"
    puts "✅ Success: Successfully wrote to and read from Redis Cache."
  else
    puts "❌ Failed: Read value does not match."
    puts "   Value: #{value.inspect}"
    puts "   Cache Store: #{Rails.cache.inspect}"
  end
rescue => e
  puts "❌ Failed: Could not connect to Redis Cache."
  puts "   Error: #{e.message}"
  puts "   Please ensure Redis is running (brew services start redis)."
end
