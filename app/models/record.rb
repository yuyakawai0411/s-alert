class Record < ApplicationRecord

  #アソシエーション
  belongs_to :card

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :phone_time
  belongs_to :expression

  #バリデーション
  validates :phone_day,  presence: true

  with_options numericality: { other_than: 0 } do
    validates :phone_time_id
    validates :expression_id
  end

end
