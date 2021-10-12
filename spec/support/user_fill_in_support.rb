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
    find("[data-testid='last_name']").set(user.last_name)
    find("[data-testid='first_name']").set(user.first_name)
    find("[data-testid='last_name_kana']").set(user.last_name_kana)
    find("[data-testid='first_name_kana']").set(user.first_name_kana)
    find("[data-testid='email']").set(user.email)
    find("[data-testid='password']").set(user.password)
    find("[data-testid='password_confirmation']").set(user.password_confirmation)
    find("[data-testid='company']").set(user.company)
    find("[data-testid='company-form']").select("株式会社")
    find("[data-testid='department']").set(user.department)
    find("[data-testid='phone_number']").set(user.phone_number)
    select "1980", from: "user_birth_day_1i"
    select "12", from: "user_birth_day_2i"
    select "11", from: "user_birth_day_3i"
  end
end