puts "🔒 Testing Mass Assignment Protection..."

# 1. Simulate malicious params
puts "\n1. Attempting to update protected attribute (created_at):"
params = ActionController::Parameters.new({
  article: {
    title: "Hacked Article",
    created_at: "2000-01-01" # This should be ignored
  }
})

# Simulate controller permitting
permitted = params.require(:article).permit(:title)

puts "Permitted params: #{permitted.inspect}"

if permitted.key?(:created_at)
  puts "❌ FAILED: created_at was permitted!"
else
  puts "✅ SUCCESS: created_at was filtered out."
end

# 2. Try to assign directly to model (Active Record protection)
puts "\n2. Attempting to mass-assign protected attribute to model:"
article = Article.new
begin
  article.attributes = { title: "Safe", created_at: "2000-01-01" }
  # Note: In Rails 4+, mass assignment protection is mainly in Controller (Strong Params).
  # Active Record default doesn't raise error for unknown attributes in `attributes=` unless configured,
  # but `created_at` is a valid attribute, just usually protected by controller.
  # Let's check if we can bypass controller.
  
  puts "Article created_at: #{article.created_at}"
  puts "⚠️  Note: Active Record allows mass-assignment if you bypass Strong Params."
  puts "    This highlights why Strong Parameters in Controller is CRITICAL."
  
rescue ActiveModel::ForbiddenAttributesError
  puts "✅ SUCCESS: ForbiddenAttributesError raised."
end

# 3. Raising error on unpermitted params
puts "\n3. Testing config.action_controller.action_on_unpermitted_parameters:"
# By default in development this might be :log or :raise
puts "Current config: #{Rails.application.config.action_controller.action_on_unpermitted_parameters.inspect}"
