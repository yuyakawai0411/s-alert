module UserExistSupport
  def user_exist_form(user)
    expect(find("[data-testid='last_name']").value).to eq(user.last_name)
    expect(find("[data-testid='first_name']").value).to eq(user.first_name)
    expect(find("[data-testid='last_name_kana']").value).to eq(user.last_name_kana)
    expect(find("[data-testid='first_name_kana']").value).to eq(user.first_name_kana)
    expect(find("[data-testid='email']").value).to eq(user.email)
    expect(find("[data-testid='company']").value).to eq(user.company)
    expect(find("[data-testid='company-form']").value).to eq("#{user.company_form_id}")
    expect(find("[data-testid='department']").value).to eq(user.department)
    expect(find("[data-testid='phone_number']").value).to eq(user.phone_number)
    expect(find('select[name="user[birth_day(1i)]"]').value).to eq("#{user.birth_day.year}")
    expect(find('select[name="user[birth_day(2i)]"]').value).to eq("#{user.birth_day.mon}")
    expect(find('select[name="user[birth_day(3i)]"]').value).to eq("#{user.birth_day.mday}")
  end
  
  def user_exist_page(user)
    expect(find("[data-testid='user-profile']")).to have_content(user.last_name)
    expect(find("[data-testid='user-profile']")).to have_content(user.first_name)
    expect(find("[data-testid='user-profile']")).to have_content(user.last_name_kana)
    expect(find("[data-testid='user-profile']")).to have_content(user.first_name_kana)
    expect(find("[data-testid='user-profile']")).to have_content(user.company)
    expect(find("[data-testid='user-profile']")).to have_content(user.company_form.form)
    expect(find("[data-testid='user-profile']")).to have_content(user.department)
    expect(find("[data-testid='user-profile']")).to have_content(user.phone_number)
  end
end