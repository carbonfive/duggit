require 'spec_helper'

describe VotesController do

  describe '#create' do
    context 'when logged in' do
      context 'and given a valid vote' do
        before do
          link = Factory :link
          user = Factory :user
          old_total = link.value

          login user
          post :create, 
            :link_id => link.id,
            :vote => {:value => 1}

          @diff = link.value - old_total
        end

        it 'creates a new vote with the right value' do
          @diff.should == 1
        end

        it 'redirects to the homepage' do
          response.should redirect_to root_path
        end
      end

      context 'and given an invalid vote' do
        before do
          link = Factory :link
          user = Factory :user
          old_total = link.value

          login user
          post :create, 
            :link_id => link.id,
            :vote => {:value => 10}

          @diff = link.value - old_total
        end

        it 'does NOT create a new vote' do
          @diff.should == 0
        end

        it 'sets a flash message' do
          flash[:alert].should be
        end

        it 'redirects to the homepage' do
          response.should redirect_to root_path
        end
      end

      context 'when not logged in' do
        before do
          post :create,
            :link_id => 1,
            :vote => {}
        end

        it 'redirects to the login page' do
          response.should redirect_to new_user_session_path
        end
      end
    end
  end

end
