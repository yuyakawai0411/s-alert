class Record < ApplicationRecord

  #アソシエーション
  belongs_to :card

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :phone_time
  belongs_to :expression
  belongs_to :phone_call

  #バリデーション
  validates :date,  presence: true

  with_options numericality: { other_than: 0 } do
    validates :phone_time_id
    validates :expression_id
    validates :phone_call_id
  end

end
