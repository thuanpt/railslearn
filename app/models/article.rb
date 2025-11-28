class Article < ApplicationRecord
  belongs_to :category, optional: true

  # Enums
  enum :status, { draft: 0, published: 1, archived: 2 }

  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true, length: { minimum: 10 }, forbidden_words: { words: ['spam', 'advertisement'] }
  validates :published_at, presence: true, if: :published?
  validate :no_clickbait_keywords

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :popular, -> { order(view_count: :desc) }

  private

  def no_clickbait_keywords
    if title.present? && title.match?(/Shocking|Secret|Top 10/i)
      errors.add(:title, "is clickbait")
    end
  end
end
