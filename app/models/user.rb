class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
                
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes
  validates :slug, uniqueness: true
  before_validation :set_slug, if: ->{ slug.nil?}

  has_one_attached :profile_picture

  def full_name
    "#{first_name} #{last_name}"
  end

  private
  
  def set_slug
    if User.find_by(slug:full_name.parameterize)
      self.slug = full_name.parameterize + SecureRandom.hex(6)
    else
      self.slug = full_name.parameterize
    end
  end

end
