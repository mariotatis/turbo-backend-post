class AddLikedAndBookmarkedToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :liked, :boolean, default: false, null: true
    add_column :posts, :bookmarked, :boolean, default: false, null: true
  end
end
