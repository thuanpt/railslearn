puts "🔍 Practice Active Record Queries..."

# 1. Basic Finders
puts "\n1. Basic Finders:"
puts "- First article: #{Article.first.title}"
puts "- Last article: #{Article.last.title}"
puts "- Find by ID (1): #{Article.find_by(id: 1)&.title}"
puts "- Find by Title: #{Article.find_by(title: 'MVC Architecture Explained')&.title}"

# 2. Where Conditions
puts "\n2. Where Conditions:"
published_articles = Article.where(status: :published)
puts "- Published articles count: #{published_articles.count}"

high_views = Article.where("view_count > ?", 100)
puts "- Articles with > 100 views: #{high_views.count}"

tech_articles = Article.joins(:category).where(categories: { name: 'Technology' })
puts "- Technology articles: #{tech_articles.count}"

# 3. Ordering & Limiting
puts "\n3. Ordering & Limiting:"
top_3_viewed = Article.order(view_count: :desc).limit(3)
puts "- Top 3 viewed articles:"
top_3_viewed.each { |a| puts "  * #{a.title} (#{a.view_count} views)" }

# 4. Aggregations
puts "\n4. Aggregations:"
puts "- Total articles: #{Article.count}"
puts "- Average view count: #{Article.average(:view_count).to_f.round(2)}"
puts "- Max view count: #{Article.maximum(:view_count)}"
puts "- Sum of all views: #{Article.sum(:view_count)}"
