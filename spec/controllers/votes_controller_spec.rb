require 'spec_helper'

describe VotesController do

  describe '#create' do
    context 'given a valid vote' do
      before do
        @id = 1
        @link = stub 'link'
        @link.
          stubs(:votes).
          returns(Vote)
        Link.
          stubs(:find).
          with(@id).
          returns(@link)

        @params = {}
        user = Factory :user
        @vote = stub 'vote' 
        @vote.
          stubs(:user=).
          with(user)
        @vote.
          stubs(:save).
          with().
          returns(true)
        Vote.
          stubs(:new).
          with(@params).
          returns(@vote)

        login user
        post :create, 
          :link_id => @id,
          :vote => @params
      end

      it 'creates a new vote' do
        Link.should have_received(:find).with(@id)
        Vote.should have_received(:new).with(@params)
        @vote.should have_received(:save).with()
      end

      it 'redirects to the homepage' do
        response.should redirect_to root_path
      end
    end

    context 'given an invalid vote' do
      before do
        @id = 1
        @link = stub 'link'
        @link.
          stubs(:votes).
          returns(Vote)
        Link.
          stubs(:find).
          with(@id).
          returns(@link)

        @params = {}
        user = Factory :user
        @vote = stub 'vote' 
        @vote.
          stubs(:user=).
          with(user)
        @vote.
          stubs(:save).
          with().
          returns(false)
        Vote.
          stubs(:new).
          with(@params).
          returns(@vote)

        login user
        post :create, 
          :link_id => @id,
          :vote => @params
      end

      it 'does NOT create a new vote' do
        Link.should have_received(:find).with(@id)
        Vote.should have_received(:new).with(@params)
        @vote.should have_received(:save).with()
      end

      it 'sets a flash message' do
        flash[:alert].should be
      end

      it 'redirects to the homepage' do
        response.should redirect_to root_path
      end
    end
  end

end
