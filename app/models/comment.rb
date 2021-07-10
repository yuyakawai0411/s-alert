class Comment < ApplicationRecord
  #アソシエーション
  belongs_to :card  
  belongs_to :user  

  validates :text, presence: true
  
end
