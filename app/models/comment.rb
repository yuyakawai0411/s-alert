class Comment < ApplicationRecord
  #アソシエーション
  belongs_to :card  
  belongs_to :user  
end
