class Category < ApplicationRecord
  has_many :articles
  validates :name, presence: true, uniqueness: true
  
  before_save :normalize_name
  
  private
  
  def normalize_name
    self.name = name.titleize if name.present?
  end
end
