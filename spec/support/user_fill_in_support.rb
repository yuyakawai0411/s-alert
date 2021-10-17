module UserFillInSupport
  def user_fill_in_form(user)
    find("[data-testid='last_name']").set(user.last_name)
    find("[data-testid='first_name']").set(user.first_name)
    find("[data-testid='last_name_kana']").set(user.last_name_kana)
    find("[data-testid='first_name_kana']").set(user.first_name_kana)
    find("[data-testid='email']").set(user.email)
    find("[data-testid='password']").set(user.password)
    find("[data-testid='password_confirmation']").set(user.password_confirmation)
    find("[data-testid='company']").set(user.company)
    find("[data-testid='company-form']").select(user.company_form.form)
    find("[data-testid='department']").set(user.department)
    find("[data-testid='phone_number']").set(user.phone_number)
    select "1980", from: "user_birth_day_1i"
    select "12", from: "user_birth_day_2i"
    select "11", from: "user_birth_day_3i"
  end
end