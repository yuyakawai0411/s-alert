module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    find("[data-testid='email']").set(user.email)
    find("[data-testid='password']").set(user.password)
    find("[data-testid='submit']").click
    expect(current_path).to eq(root_path)
  end
end