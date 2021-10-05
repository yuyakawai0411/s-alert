module CardExistSupport

  def card_exist_form(card)
    expect(find('input[name="card[s_last_name]"]').value).to eq(card.s_last_name)
    expect(find('input[name="card[s_first_name]"]').value).to eq(card.s_first_name)
    expect(find('input[name="card[s_last_name_kana]"]').value).to eq(card.s_last_name_kana)
    expect(find('input[name="card[s_first_name_kana]"]').value).to eq(card.s_first_name_kana)
    expect(find('input[name="card[s_company]"]').value).to eq(card.s_company)
    expect(find('select[name="card[s_company_form_id]"]').value).to eq("#{card.s_company_form_id}")
    expect(find('input[name="card[s_department]"]').value).to eq(card.s_department)
    expect(find('input[name="card[s_phone_number]"]').value).to eq(card.s_phone_number)
    expect(find('select[name="card[s_birth_day(1i)]"]').value).to eq("#{card.s_birth_day.year}")
    expect(find('select[name="card[s_birth_day(2i)]"]').value).to eq("#{card.s_birth_day.mon}")
    expect(find('select[name="card[s_birth_day(3i)]"]').value).to eq("#{card.s_birth_day.mday}")
  end

  def card_exist_page(card, exist)
    if exist == 'yes'
      expect(page).to have_content(card.s_last_name)
      expect(page).to have_content(card.s_first_name)
      expect(page).to have_content(card.s_last_name_kana)
      expect(page).to have_content(card.s_first_name_kana)
      expect(page).to have_content(card.s_company)
      expect(page).to have_content(card.s_company_form.form)
      expect(page).to have_content(card.s_department)
      expect(page).to have_content(card.s_phone_number)
    else exist == 'no'
      expect(page).to have_no_content(card.s_last_name)
      expect(page).to have_no_content(card.s_first_name)
      expect(page).to have_no_content(card.s_last_name_kana)
      expect(page).to have_no_content(card.s_first_name_kana)
      expect(page).to have_no_content(card.s_company)
      expect(page).to have_no_content(card.s_company_form.form)
      expect(page).to have_no_content(card.s_department)
      expect(page).to have_no_content(card.s_phone_number)
    end
  end
end