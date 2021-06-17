class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.date :day, null: false 
      t.integer :time_id, null: false 
      t.integer :expression_id, null: false 
      t.references :card, foreign_key: true
      t.timestamps
    end
  end
end
