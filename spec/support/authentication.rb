module Authentication

  def login(user)
    user_session = stub 'user session'
    user_session.
      stubs(:user).
      returns(user)

    UserSession.
      stubs(:find).
      with().
      returns(user_session)
  end

end
