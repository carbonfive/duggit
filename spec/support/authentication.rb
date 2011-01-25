require 'authlogic/test_case/rails_request_adapter'
require 'authlogic/test_case/mock_cookie_jar'

def activate_authlogic
  Authlogic::Session::Base.controller = Authlogic::TestCase::RailsRequestAdapter.new(request)
end

def login(user)
  activate_authlogic
  UserSession.create(user)
end