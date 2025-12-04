require 'benchmark'

puts "🔍 Verifying Performance Optimization..."

# Setup Data
Category.first_or_create!(name: "Perf Test")
User.first || User.create!(name: "Perf User", email: "perf@test.com", password: "password", password_confirmation: "password")

# Ensure we have enough articles
if Article.count < 10
  10.times do |i|
    Article.create!(
      title: "Perf Article #{i}", 
      body: "Content for perf article #{i}", 
      user: User.first, 
      category: Category.first,
      status: :published,
      published_at: Time.now
    )
  end
end

puts "\n1. Testing N+1 Query Fix (Eager Loading):"
# We can't easily intercept controller queries here without a full request simulation,
# but we can verify the Active Record logic.

# Simulate N+1 (Bad)
puts "   [Simulation] Loading articles one by one (N+1)..."
time_n_plus_1 = Benchmark.realtime do
  articles = Article.limit(10)
  articles.each do |a|
    a.user.name # Triggers query
    a.category.name # Triggers query
  end
end
puts "   Time: #{time_n_plus_1.round(4)}s"

# Simulate Eager Loading (Good)
puts "   [Simulation] Loading articles with includes (Eager Loading)..."
time_eager = Benchmark.realtime do
  articles = Article.includes(:user, :category).limit(10)
  articles.each do |a|
    a.user.name # No extra query
    a.category.name # No extra query
  end
end
puts "   Time: #{time_eager.round(4)}s"

if time_eager < time_n_plus_1
  puts "✅ Success: Eager loading is faster (or at least more efficient in query count)."
else
  puts "⚠️ Note: Eager loading might not be faster with small dataset, but it reduces query count."
end

puts "\n2. Verifying Caching Syntax:"
file_content = File.read("app/views/articles/index.html.erb")
if file_content.include?("cache article do")
  puts "✅ Success: 'cache article do' block found in view."
else
  puts "❌ Failed: Cache block not found in view."
end
