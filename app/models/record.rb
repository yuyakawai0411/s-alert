class Record < ApplicationRecord

  #アソシエーション
  belongs_to :card

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :phone_time
  belongs_to :expression

end
