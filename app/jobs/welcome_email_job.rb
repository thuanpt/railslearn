class WelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    Rails.logger.info "📨 Starting background job: Sending welcome email to #{user.email}..."
    
    # Send email using Action Mailer
    # We use deliver_now because the job itself is already running in background via Sidekiq
    UserMailer.welcome_email(user).deliver_now
    
    Rails.logger.info "✅ Done: Welcome email sent to #{user.email}!"
  end
end
