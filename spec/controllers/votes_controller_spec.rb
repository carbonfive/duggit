require 'spec_helper'

describe VotesController do

  describe '#create' do
    context 'when logged in' do
      context 'and given a valid vote' do
        before do
          link = Factory :link
          user = Factory :user

          @value = 1

          login user

          post :create, 
            :link_id => link.id,
            :vote => {:value => @value}

          link.reload
          @vote = link.votes.detect {|vote| vote.user_id = user.id}
        end

        it 'creates a new vote' do
          @vote.should be
        end

        it 'sets the vote value' do
          @vote.value.should == @value
        end

        it 'redirects to the homepage' do
          response.should redirect_to root_path
        end
      end

      context 'and given an invalid vote' do
        before do
          link = Factory :link
          user = Factory :user

          invalid_value = 10

          login user

          post :create, 
            :link_id => link.id,
            :vote => {:value => invalid_value}

          link.reload
          @vote = link.votes.detect {|vote| vote.user_id = user.id}
        end

        it 'does NOT create a new vote' do
          @vote.should_not be
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
