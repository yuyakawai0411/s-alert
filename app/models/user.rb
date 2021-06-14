class User < ApplicationRecord
  
  #アソシエーション
  has_many :cards

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :company_form

  
  #バリデーション
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :company_form_id, numericality: { other_than: 0 }
  
  with_options presence: true do
    validates :company
    validates :department
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字を使用してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'はカタカナ文字を使用してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end
  
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
  
end
