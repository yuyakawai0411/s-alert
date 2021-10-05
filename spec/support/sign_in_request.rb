module SignInRequest
  def sign_in_request(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    expect(response.status).to redirect_to root_path
  end
end