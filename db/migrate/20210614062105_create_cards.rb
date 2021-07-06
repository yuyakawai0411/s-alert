class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :s_last_name, null: false
      t.string :s_first_name, null: false
      t.string :s_last_name_kana, null: false
      t.string :s_first_name_kana, null: false
      t.string :s_company, null: false
      t.integer :s_company_form_id, null: false
      t.string :s_department, null: false
      t.string :s_phone_number, null: false
      t.date :s_birth_day, null: false
      t.string :s_hobby_top
      t.string :s_hobby_medium
      t.string :s_hobby_row
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
