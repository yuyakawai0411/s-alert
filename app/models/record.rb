class Record < ApplicationRecord

  belongs_to :card

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :phone_time
  belongs_to :expression
  belongs_to :phone_call

  validates :date,  presence: true
  validates :phone_call_id, numericality: { other_than: 0,  message: 'を入力してください' }
  validates :phone_time_id, numericality: { greater_than_or_equal_to: 7, less_than_or_equal_to:22, message: 'は指定の範囲内で選択してください' }
  validates :expression_id, numericality: { greater_than_or_equal_to: -3, less_than_or_equal_to:3, message: 'は指定の範囲内で選択してください' }

  private
  # 着信履歴をCSVでインポート
  def self.import(file, card_id)
    list = [ ] 
    if file.blank? || (File.extname(file.original_filename) != ".csv")
      list << {
        date: '',
        phone_time_id: '',
        expression_id: '',
        phone_call_id: '',
        card_id: ''
      }
      return list
    else
      CSV.foreach(file.path, headers: true) do |row|
        list << {
          date: row[0],
          phone_time_id: row[1],
          expression_id: row[2],
          phone_call_id: 1,
          card_id: card_id
        }
      end
      return list
    end
  end
end
