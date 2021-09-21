module BasicPassSupport
  def basic_pass(path) 
    username = Rails.application.credentials.basic[:BASIC_AUTH_USER]
    password = Rails.application.credentials.basic[:BASIC_AUTH_PASSWORD]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end
end