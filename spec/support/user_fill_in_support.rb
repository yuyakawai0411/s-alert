module UserFillInSupport
  def user_exist_form(user)
    expect(find('input[name="user[last_name]"]').value).to eq(user.last_name)
    expect(find('input[name="user[first_name]"]').value).to eq(user.first_name)
    expect(find('input[name="user[last_name_kana]"]').value).to eq(user.last_name_kana)
    expect(find('input[name="user[first_name_kana]"]').value).to eq(user.first_name_kana)
    expect(find('input[name="user[email]"]').value).to eq(user.email)
    expect(find('input[name="user[company]"]').value).to eq(user.company)
    expect(find('select[name="user[company_form_id]"]').value).to eq("#{user.company_form_id}")
    expect(find('input[name="user[department]"]').value).to eq(user.department)
    expect(find('input[name="user[phone_number]"]').value).to eq(user.phone_number)
    expect(find('select[name="user[birth_day(1i)]"]').value).to eq("#{user.birth_day.year}")
    expect(find('select[name="user[birth_day(2i)]"]').value).to eq("#{user.birth_day.mon}")
    expect(find('select[name="user[birth_day(3i)]"]').value).to eq("#{user.birth_day.mday}")
  end

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