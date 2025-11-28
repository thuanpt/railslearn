puts "🔍 N+1 Problem Demo..."

puts "\n1. N+1 Problem (Bad):"
# Rails logger to stdout to see SQL queries
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "--- Start N+1 ---"
articles = Article.all
articles.each do |article|
  # This triggers a separate query for each article to fetch the category
  puts "Article: #{article.title} -> Category: #{article.category&.name}"
end
puts "--- End N+1 ---"

puts "\n\n2. Eager Loading (Good):"
puts "--- Start Eager Loading ---"
# Includes loads categories in a separate query (or join) upfront
articles_with_includes = Article.includes(:category).all
articles_with_includes.each do |article|
  # No extra query here
  puts "Article: #{article.title} -> Category: #{article.category&.name}"
end
puts "--- End Eager Loading ---"
