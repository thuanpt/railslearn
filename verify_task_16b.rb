require 'sidekiq/api'

puts "🔍 Verifying Sidekiq & Action Mailer..."

# 1. Check Redis Connection
begin
  Sidekiq.redis { |conn| conn.ping }
  puts "✅ Redis is connected."
rescue Redis::CannotConnectError
  puts "❌ Redis is NOT connected. Please start redis-server."
  exit
end

# 2. Enqueue Job
user = User.first || User.create!(name: "Sidekiq User", email: "sidekiq@test.com", password: "password", password_confirmation: "password")
puts "\nEnqueuing WelcomeEmailJob for #{user.email}..."
WelcomeEmailJob.perform_later(user)

# 3. Check Queue
queue = Sidekiq::Queue.new("default")
puts "Current Queue Size: #{queue.size}"

# Note: If Sidekiq worker is running, the queue size might be 0 because it picked up the job immediately.
# If Sidekiq worker is NOT running, the queue size should be > 0.

puts "\nVerification Steps:"
puts "1. Run 'bundle exec sidekiq' in a separate terminal."
puts "2. You should see the job processing in Sidekiq logs."
puts "3. A browser tab should open (Letter Opener) with the email content."
