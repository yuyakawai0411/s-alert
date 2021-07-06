class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.date :date, null: false 
      t.integer :phone_time_id, null: false 
      t.integer :expression_id, null: false
      t.integer :phone_call_id , null: false
      t.references :card, foreign_key: true
      t.timestamps
    end
  end
end
