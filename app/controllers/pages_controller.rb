class PagesController < ApplicationController
  # Action để hiển thị trang chủ
  def home
    # Biến instance (@) có thể được sử dụng trong view
    @welcome_message = "Chào mừng đến với Rails!"
    @current_time = Time.now
    
    # Rails tự động render view: app/views/pages/home.html.erb
    # Không cần viết: render :home
  end
  
  # Action để hiển thị trang About
  def about
    @description = "Đây là trang về chúng tôi"
  end
  
  # Action để hiển thị trang Contact
  def contact
    @email = "contact@example.com"
  end
end
