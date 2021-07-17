class Notice < ApplicationRecord
  
  belongs_to :user
  
  validate :past_date

  with_options presence: true do
    validates :description
  end
  
  # メール通知にて、過去の日付を選択できないようにする
  def past_date
    errors.add(:notice_date,'は明日以降の日付を入力してください') if notice_date.nil? || notice_date < Date.today
  end

end
