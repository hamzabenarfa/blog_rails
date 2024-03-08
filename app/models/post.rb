class Post < ApplicationRecord
    belongs_to :user

    has_many :resources, dependent: :destroy
    has_rich_text :content
    
    has_one_attached :cover
    validate :correct_content_type

    private

    def correct_content_type
        if cover.attached? && !cover.content_type.in?(%w(image/png image/jpg image/jpeg))
         errors.add(:cover, 'must be a PNG, JPG, or JPEG image')
        end
    end


end
