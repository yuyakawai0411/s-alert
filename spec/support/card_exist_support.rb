module CardExistSupport
  def card_exist(card, exist)
    if exist == 'yes'
      expect(page).to have_content(card.s_last_name)
      expect(page).to have_content(card.s_first_name)
      expect(page).to have_content(card.s_last_name_kana)
      expect(page).to have_content(card.s_first_name_kana)
      expect(page).to have_content(card.s_company)
      expect(page).to have_content(card.s_company_form.form)
      expect(page).to have_content(card.s_department)
      expect(page).to have_content(card.s_phone_number)
    else
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