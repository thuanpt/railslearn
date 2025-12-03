class Category < ApplicationRecord
  has_many :articles
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  
  before_save :normalize_name
  
  private
  
  def normalize_name
    self.name = name.titleize if name.present?
  end
end
