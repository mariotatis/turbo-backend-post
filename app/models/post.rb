class Post < ApplicationRecord

    belongs_to :user

    validates :title, presence: true
    validates :description, presence: true
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "user_id", "description", "id", "image_url", "tags", "title", "updated_at", "liked", "bookmarked"]
    end
end
