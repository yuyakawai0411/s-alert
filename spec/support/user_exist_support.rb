module UserExistSupport
  def user_exist_page(user)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name_kana)
      expect(page).to have_content(user.first_name_kana)
      expect(page).to have_content(user.company)
      expect(page).to have_content(user.department)
  end
end