class Notice < ApplicationRecord
  #アソシエーション
  belongs_to :user
  #バリデーション
  validate :past_date

  with_options presence: true do
    validates :description
  end
  
  def past_date
    errors.add(:notice_date,'は明日以降の日付を入力してください') if notice_date.nil? || notice_date < Date.today
  end

end
