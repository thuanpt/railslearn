require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @category = categories(:one)
    @article = Article.new(
      title: "Test Article", 
      body: "This is a test article body", 
      user: @user, 
      category: @category,
      status: :published,
      published_at: Time.current
    )
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "title should be present" do
    @article.title = " "
    assert_not @article.valid?
  end

  test "title should be at least 5 characters" do
    @article.title = "a" * 4
    assert_not @article.valid?
  end

  test "body should be present" do
    @article.body = " "
    assert_not @article.valid?
  end

  test "body should be at least 10 characters" do
    @article.body = "a" * 9
    assert_not @article.valid?
  end

  test "should belong to user" do
    @article.user = nil
    assert_not @article.valid?
  end

  test "should belong to category" do
    @article.category = nil
    assert_not @article.valid?
  end

  test "should have status enum" do
    assert @article.published?
    @article.draft!
    assert @article.draft?
  end
end
