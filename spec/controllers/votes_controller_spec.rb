require 'spec_helper'

describe VotesController do

  describe '#create' do
    context 'when logged in' do
      context 'and given a valid vote' do
        before do
          link_id = 1
          @link = stub 'link'
          @link.
            stubs(:votes).
            returns(Vote)
          Link.
            stubs(:find).
            with(link_id).
            returns(@link)

          @params = {}
          @vote = stub 'vote' 
          @vote.
            stubs(:update_attributes).
            with(@params).
            returns(true)

          user = Factory :user
          Vote.
            stubs(:find_or_create_by_user_id).
            with(user.id).
            returns(@vote)

          login user

          post :create, 
            :link_id => link_id,
            :vote => @params
        end

        it 'creates a new vote' do
          @vote.should have_received(:update_attributes).with(@params)
        end

        it 'redirects to the homepage' do
          response.should redirect_to root_path
        end
      end

      context 'and given an invalid vote' do
        before do
          link_id = 1
          @link = stub 'link'
          @link.
            stubs(:votes).
            returns(Vote)
          Link.
            stubs(:find).
            with(link_id).
            returns(@link)

          @params = {}
          @vote = stub 'vote' 
          @vote.
            stubs(:update_attributes).
            with(@params).
            returns(false)
          user = Factory :user
          Vote.
            stubs(:find_or_create_by_user_id).
            with(user.id).
            returns(@vote)

          login user

          post :create, 
            :link_id => link_id,
            :vote => @params
        end

        it 'does NOT create a new vote' do
          @vote.should have_received(:update_attributes).with(@params)
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
