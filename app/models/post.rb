class Post < ApplicationRecord
    belongs_to :user

    has_many :resources, dependent: :destroy
    has_rich_text :content



end
