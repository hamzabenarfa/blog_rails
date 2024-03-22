class Post < ApplicationRecord
    belongs_to :user

    has_many :resources, dependent: :destroy
    has_rich_text :content
    has_one_attached :cover
    has_many :comments, dependent: :destroy
    has_many :likes
    
    validate :correct_content_type
    validates :title, presence: true
    validates :content, presence: true
    validates :cover, presence: true

    scope :sorted , -> { order(published_at: :desc) }
    scope :draft , -> { where(published_at: nil) }
    scope :published, -> { where("published_at <= ?", Time.current) }
    scope :scheduled, -> { where("published_at > ?", Time.current) }
   
    def draft? 
        published_at.nil?
    end

    def published?
        published_at.present? && published_at <= Time.current
    end

    def scheduled?
        published_at.present? && published_at > Time.current
    end

    def liked_by?(user)
        likes.where(user: user).any?
    end

    def like(user)
        likes.where(user: user).first_or_create
    end

    def unlike(user)
        likes.where(user: user).destroy_all
    end
    
    private

    def correct_content_type
        if cover.attached? && !cover.content_type.in?(%w(image/png image/jpg image/jpeg))
         errors.add(:cover, 'must be a PNG, JPG, or JPEG image')
        end
    end

end
