require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    # Simulate login by visiting login page and filling form
    # Because system tests use a real browser, we can't just set session directly
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Login"
    assert_text "Hi, User One"
  end

  test "creating a new article" do
    visit articles_url
    click_on "New Article" # Assuming the link on index page is "New Article" or similar. Let's check index page too if needed, but usually it's standard. 
    # Wait, the index page button might be different. I'll check index page later if it fails, but for now let's fix form fields.
    
    fill_in "Tiêu đề:", with: "System Test Article"
    fill_in "Nội dung:", with: "This is a body for the system test article."
    select "Technology", from: "Danh mục:"
    
    check "Xuất bản ngay"

    click_on "Tạo Article"

    assert_text "Article was successfully created"
    assert_text "System Test Article"
  end
end
