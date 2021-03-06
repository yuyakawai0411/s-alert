class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.date :notice_date,  null: false 
      t.string :description,  null: false 
      t.string :topic
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
