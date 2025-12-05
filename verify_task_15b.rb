require 'net/http'
require 'json'
require 'uri'

BASE_URL = "http://localhost:3000/api/v1"

puts "🔍 Verifying API Authentication..."

# 1. Try to Create Article WITHOUT Token (Should Fail)
puts "\n1. POST #{BASE_URL}/articles (No Token)"
uri = URI("#{BASE_URL}/articles")
data = { article: { title: "Unauthorized Article", body: "Should fail", category_id: 1, status: "published" } }
response = Net::HTTP.post(uri, data.to_json, "Content-Type" => "application/json")
puts "Status: #{response.code}" # Expect 401
if response.code == "401"
  puts "✅ Success: Unauthorized request blocked."
else
  puts "❌ Failed: Request should be blocked."
end

# 2. Login to get Token
puts "\n2. POST #{BASE_URL}/auth/login"
login_uri = URI("#{BASE_URL}/auth/login")
# Ensure user exists
user = User.find_by(email: "job@test.com") || User.create!(name: "Job User", email: "job@test.com", password: "password", password_confirmation: "password")
login_data = { email: user.email, password: "password" }
response = Net::HTTP.post(login_uri, login_data.to_json, "Content-Type" => "application/json")
puts "Status: #{response.code}"

token = nil
if response.code == "200"
  body = JSON.parse(response.body)
  token = body["token"]
  puts "✅ Success: Login successful. Token: #{token[0..20]}..."
else
  puts "❌ Failed: Login failed."
  puts response.body
  exit
end

# 3. Create Article WITH Token (Should Succeed)
puts "\n3. POST #{BASE_URL}/articles (With Token)"
category_id = Category.first&.id || 1
article_data = { article: { title: "Authorized Article", body: "Created with JWT", category_id: category_id, status: "published", published_at: Time.now } }

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.path, "Content-Type" => "application/json", "Authorization" => "Bearer #{token}")
request.body = article_data.to_json
response = http.request(request)

puts "Status: #{response.code}"
if response.code == "201"
  puts "✅ Success: Article created with valid token."
else
  puts "❌ Failed: Article creation failed."
  puts response.body
end
