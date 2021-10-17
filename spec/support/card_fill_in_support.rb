module CardFillInSupport
  def card_fill_in_form(card, image_path)
    attach_file("card_image", image_path)
    find("[data-testid='s_last_name']").set(card.s_last_name)
    find("[data-testid='s_first_name']").set(card.s_first_name)
    find("[data-testid='s_last_name_kana']").set(card.s_last_name_kana)
    find("[data-testid='s_first_name_kana']").set(card.s_first_name_kana)
    find("[data-testid='s_company']").set(card.s_company)
    find("[data-testid='s_company_form']").select(card.s_company_form.form) 
    find("[data-testid='s_department']").set(card.s_department)
    find("[data-testid='s_phone_number']").set(card.s_phone_number)
    select "#{card.s_birth_day.year}", from: "card[s_birth_day(1i)]"
    select "#{card.s_birth_day.mon}", from: "card[s_birth_day(2i)]"
    select "#{card.s_birth_day.mday}", from: "card[s_birth_day(3i)]"
  end
end