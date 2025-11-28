class AddDetailsToArticles < ActiveRecord::Migration[8.1]
  def change
    add_column :articles, :view_count, :integer, default: 0
    add_column :articles, :status, :integer, default: 0
  end
end
