require 'authlogic/test_case/rails_request_adapter'
require 'authlogic/test_case/mock_cookie_jar'

def activate_authlogic(request)
  Authlogic::Session::Base.controller = Authlogic::TestCase::RailsRequestAdapter.new(request)
end

def login(request, user)
  activate_authlogic(request)
  UserSession.create(user)
end