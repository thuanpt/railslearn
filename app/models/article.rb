class Article < ApplicationRecord
  # Enums
  enum :status, { draft: 0, published: 1, archived: 2 }

  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true, length: { minimum: 10 }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :popular, -> { order(view_count: :desc) }
end
