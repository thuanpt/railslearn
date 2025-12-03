puts "🔍 Verifying User Authentication..."

# 1. Create User
puts "\n1. Creating User:"
User.destroy_all # Clean up
user = User.create(
  name: "Test User",
  email: "test@example.com",
  password: "password123",
  password_confirmation: "password123"
)

if user.persisted?
  puts "✅ Success: User created"
  puts "Password Digest: #{user.password_digest[0..20]}..."
else
  puts "❌ Failed: User not created"
  puts user.errors.full_messages
end

# 2. Authenticate (Correct Password)
puts "\n2. Authenticating (Correct Password):"
authenticated_user = user.authenticate("password123")

if authenticated_user
  puts "✅ Success: Authentication successful"
else
  puts "❌ Failed: Authentication failed"
end

# 3. Authenticate (Incorrect Password)
puts "\n3. Authenticating (Incorrect Password):"
failed_user = user.authenticate("wrongpassword")

if !failed_user
  puts "✅ Success: Authentication failed as expected"
else
  puts "❌ Failed: Authentication should have failed"
end

# 4. Validations
puts "\n4. Testing Validations:"
invalid_user = User.new(name: "No Email", password: "123")
invalid_user.save

if invalid_user.errors[:email].any? && invalid_user.errors[:password].any?
  puts "✅ Success: Validations working (Email required, Password too short)"
else
  puts "❌ Failed: Validations missing"
end
