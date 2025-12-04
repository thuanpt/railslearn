require 'net/http'
require 'json'
require 'uri'

BASE_URL = "http://localhost:3000/api/v1/articles"

puts "🔍 Verifying API..."

# Helper to print response
def print_response(response)
  puts "Status: #{response.code}"
  begin
    body = JSON.parse(response.body)
    puts "Body: #{body.inspect[0..100]}..." # Truncate for readability
    body
  rescue JSON::ParserError
    puts "Body: #{response.body}"
    nil
  end
end

# 1. GET Index
puts "\n1. GET #{BASE_URL}"
uri = URI(BASE_URL)
response = Net::HTTP.get_response(uri)
print_response(response)

# 2. POST Create
puts "\n2. POST #{BASE_URL}"
# Ensure we have a category
category_id = Category.first&.id || 1
data = { article: { title: "API Article", body: "Created via API", category_id: category_id, status: "published", published_at: Time.now } }
response = Net::HTTP.post(uri, data.to_json, "Content-Type" => "application/json")
created_article = print_response(response)
article_id = created_article["id"] if created_article

if article_id
  # 3. GET Show
  puts "\n3. GET #{BASE_URL}/#{article_id}"
  show_uri = URI("#{BASE_URL}/#{article_id}")
  response = Net::HTTP.get_response(show_uri)
  print_response(response)

  # 4. PUT Update
  puts "\n4. PUT #{BASE_URL}/#{article_id}"
  update_data = { article: { title: "API Article Updated" } }
  http = Net::HTTP.new(show_uri.host, show_uri.port)
  request = Net::HTTP::Put.new(show_uri.path, "Content-Type" => "application/json")
  request.body = update_data.to_json
  response = http.request(request)
  print_response(response)

  # 5. DELETE Destroy
  puts "\n5. DELETE #{BASE_URL}/#{article_id}"
  request = Net::HTTP::Delete.new(show_uri.path)
  response = http.request(request)
  puts "Status: #{response.code}" # Should be 204 No Content
else
  puts "❌ Failed to create article, skipping CRUD tests"
end

# 6. Error Handling (404)
puts "\n6. GET #{BASE_URL}/999999 (Not Found)"
error_uri = URI("#{BASE_URL}/999999")
response = Net::HTTP.get_response(error_uri)
print_response(response)
