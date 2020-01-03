module AuthorizationHelper
  # https://dev.to/risafj/tips-for-testing-authentication-with-devisetokenauth-in-rails-api-55pj
  def get_token_for_user(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post '/login',
      params: { user: {
        email: user.email,
        password: 'super123'
      }
    }, as: :json
    # The three categories below are the ones you need as authentication headers.
    response.headers['Authorization']
  end
end