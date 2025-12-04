class WelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    Rails.logger.info "📨 Starting background job: Sending welcome email to #{user.email}..."
    
    # Simulate a long-running task (e.g., contacting an external email service)
    sleep 5
    
    Rails.logger.info "✅ Done: Welcome email sent to #{user.email}!"
  end
end
