class Card < ApplicationRecord

  #アソシエーション
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :company_form

  #バリデーション
  validates :s_company_form_id, numericality: { other_than: 0 }
  
  with_options presence: true do
    validates :s_company
    validates :s_department
    validates :s_birth_day
    validates :s_phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. except hyphen(-)' }
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字を使用してください' } do
    validates :s_last_name
    validates :s_first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'はカタカナ文字を使用してください' } do
    validates :s_last_name_kana
    validates :s_first_name_kana
  end

  private

end
