require 'spec_helper'

describe UsersController do
  describe '#new' do
    before do
      get :new
    end

    it 'displays the registration page' do
      response.should render_template(:new)
    end
  end
end
