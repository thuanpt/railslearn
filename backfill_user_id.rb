# Create a default user if none exists
default_user = User.first || User.create!(
  name: "System Admin", 
  email: "admin@example.com", 
  password: "password", 
  password_confirmation: "password"
)

# Assign all orphan articles to this user
Article.where(user_id: nil).update_all(user_id: default_user.id)

puts "Assigned all articles to User: #{default_user.name}"
