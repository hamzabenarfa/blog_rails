class Post < ApplicationRecord
    belongs_to :user

    has_many :resources, dependent: :destroy
    has_rich_text :content
    
    has_one_attached :cover
    validate :correct_content_type

    validates :title, presence: true
    validates :content, presence: true
    validates :cover, presence: true

    scope :draft , -> { where(published_at: nil) }
    scope :published, -> { where("published_at <= ?", Time.current) }
    scope :scheduled, -> { where("published_at > ?", Time.current) }
    private

    def correct_content_type
        if cover.attached? && !cover.content_type.in?(%w(image/png image/jpg image/jpeg))
         errors.add(:cover, 'must be a PNG, JPG, or JPEG image')
        end
    end

    def draft? 
        published_at.nil?
    end

    def published?
        published_at.present? && published_at <= Time.current
    end

    def scheduled?
        published_at.present? && published_at > Time.current
    end
    
end
