module CardFillInSupport
  def card_fill_in_form(card, image_path)
    attach_file("card_image", image_path)
    fill_in "card[s_last_name]", with: card.s_last_name
    fill_in "card[s_first_name]", with: card.s_first_name
    fill_in "card[s_last_name_kana]", with: card.s_last_name_kana
    fill_in "card[s_first_name_kana]", with: card.s_first_name_kana
    fill_in "card[s_company]", with: card.s_company
    select "#{card.s_company_form.form}", from: "card[s_company_form_id]"
    fill_in "card[s_department]", with: card.s_department
    fill_in "card[s_phone_number]", with: card.s_phone_number
    select "#{card.s_birth_day.year}", from: "card[s_birth_day(1i)]"
    select "#{card.s_birth_day.mon}", from: "card[s_birth_day(2i)]"
    select "#{card.s_birth_day.mday}", from: "card[s_birth_day(3i)]"
  end
end