module CardExistSupport

  def card_exist_form(card)
    expect(find("[data-testid='s_last_name']").value).to eq(card.s_last_name)
    expect(find("[data-testid='s_first_name']").value).to eq(card.s_first_name)
    expect(find("[data-testid='s_last_name_kana']").value).to eq(card.s_last_name_kana)
    expect(find("[data-testid='s_first_name_kana']").value).to eq(card.s_first_name_kana)
    expect(find("[data-testid='s_company']").value).to eq(card.s_company)
    expect(find("[data-testid='s_company_form']").value).to eq("#{card.s_company_form_id}")
    expect(find("[data-testid='s_department']").value).to eq(card.s_department)
    expect(find("[data-testid='s_phone_number']").value).to eq(card.s_phone_number)
    expect(find('select[name="card[s_birth_day(1i)]"]').value).to eq("#{card.s_birth_day.year}")
    expect(find('select[name="card[s_birth_day(2i)]"]').value).to eq("#{card.s_birth_day.mon}")
    expect(find('select[name="card[s_birth_day(3i)]"]').value).to eq("#{card.s_birth_day.mday}")
  end

  def card_exist_page(card)
    expect(find("[data-testid='card-info']")).to have_content(card.s_last_name)
    expect(find("[data-testid='card-info']")).to have_content(card.s_last_name)
    expect(find("[data-testid='card-info']")).to have_content(card.s_first_name)
    expect(find("[data-testid='card-info']")).to have_content(card.s_last_name_kana)
    expect(find("[data-testid='card-info']")).to have_content(card.s_first_name_kana)
    expect(find("[data-testid='card-info']")).to have_content(card.s_company)
    expect(find("[data-testid='card-info']")).to have_content(card.s_company_form.form)
    expect(find("[data-testid='card-info']")).to have_content(card.s_department)
    expect(find("[data-testid='card-info']")).to have_content(card.s_phone_number)
  end

  def card_not_exist_page(card)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_last_name)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_first_name)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_last_name_kana)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_first_name_kana)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_company)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_company_form.form)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_department)
    expect(find("[data-testid='card-info']")).to have_no_content(card.s_phone_number)
   end

   def card_favorite_exist_page(card)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_last_name)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_first_name)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_last_name_kana)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_first_name_kana)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_company)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_company_form.form)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_department)
    expect(find("[data-testid='favorite-card-info']")).to have_content(card.s_phone_number)
   end

   def card_favorite_not_exist_page(card)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_last_name)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_first_name)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_last_name_kana)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_first_name_kana)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_company)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_company_form.form)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_department)
    expect(find("[data-testid='favorite-card-info']")).to have_no_content(card.s_phone_number)
   end

   def card_post_exist_page(card)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_last_name)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_first_name)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_last_name_kana)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_first_name_kana)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_company)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_company_form.form)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_department)
    expect(find("[data-testid='post-card-info']")).to have_content(card.s_phone_number)
   end

   def card_post_not_exist_page(card)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_last_name)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_first_name)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_last_name_kana)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_first_name_kana)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_company)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_company_form.form)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_department)
    expect(find("[data-testid='post-card-info']")).to have_no_content(card.s_phone_number)
   end
end