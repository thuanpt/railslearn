puts "🔍 Verifying Background Jobs..."

# 1. Setup User
user = User.first || User.create!(name: "Job User", email: "job@test.com", password: "password", password_confirmation: "password")
puts "User: #{user.email}"

# 2. Test perform_now (Synchronous)
puts "\n1. Testing perform_now (Synchronous):"
puts "   (This should pause for 5 seconds...)"
start_time = Time.now
WelcomeEmailJob.perform_now(user)
duration = Time.now - start_time
puts "   Done in #{duration.round(2)} seconds."

if duration >= 5
  puts "✅ Success: Job ran synchronously and simulated delay."
else
  puts "❌ Failed: Job finished too quickly (did it sleep?)"
end

# 3. Test perform_later (Asynchronous)
puts "\n2. Testing perform_later (Asynchronous):"
puts "   (This should return immediately)"
start_time = Time.now
WelcomeEmailJob.perform_later(user)
duration = Time.now - start_time
puts "   Enqueued in #{duration.round(4)} seconds."

if duration < 1
  puts "✅ Success: Job enqueued immediately (Async)."
  puts "   Check log/development.log to see the job execution output later."
else
  puts "❌ Failed: Enqueue took too long (is it running inline?)"
end
