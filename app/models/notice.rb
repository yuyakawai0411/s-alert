class Notice < ApplicationRecord
  #アソシエーション
  belongs_to :user
  #バリデーション
  validate :past_date

  def past_date
    errors.add(:notice_date,'過去の日付は入力できません') if notice_date.nil? || notice_date < Date.today
  end

end
