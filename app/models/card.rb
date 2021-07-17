class Card < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :records, dependent: :destroy
  has_many :favorites
  has_many :users, through: :favorites
  has_many :comments, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :s_company_form

  validates :s_company_form_id, numericality: { other_than: 0 , message: 'を入力してください'}

  with_options presence: true do
    validates :s_company
    validates :s_department
    validates :s_birth_day
    validates :s_phone_number
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字を使用してください' } do
    validates :s_last_name
    validates :s_first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'はカタカナ文字を使用してください' } do
    validates :s_last_name_kana
    validates :s_first_name_kana
  end

  # 名刺検索機能
  def self.search(search)
    if search != ""
      Card.where("s_last_name LIKE(?) OR s_first_name LIKE(?) OR s_company LIKE(?) OR s_department LIKE(?) OR s_last_name_kana LIKE(?) OR s_first_name_kana LIKE(?)" ,"%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      Card.order('created_at DESC')
    end
  end

  # 現在ログインしているユーザーがお気に入りしている名刺を確認
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
