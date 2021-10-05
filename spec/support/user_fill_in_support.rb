module UserFillInSupport
  def user_fill_in_form(user)
    fill_in "user_last_name", with: user.last_name
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name_kana", with: user.last_name_kana
    fill_in "user_first_name_kana", with: user.first_name_kana
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password_confirmation
    fill_in "user_company", with: user.company
    select "株式会社",  from: "item-category"
    fill_in "user_department", with: user.department
    fill_in "user_phone_number", with: user.phone_number
    select "1980", from: "user_birth_day_1i"
    select "12", from: "user_birth_day_2i"
    select "11", from: "user_birth_day_3i"
  end
end