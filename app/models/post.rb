class Post < ApplicationRecord

    belongs_to :user

    validates :title, presence: true
    validates :description, presence: true
    
    def self.ransackable_attributes(auth_object = nil)
        [
        "id",
        "user_id",
        "title",
        "description",        
        "image_url",
        "tags",
        "post_url",
        "liked",
        "bookmarked",
        "created_at",
        "updated_at"
        ]

    end
end
