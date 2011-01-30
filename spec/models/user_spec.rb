require 'spec_helper'

describe User do

  describe '#eligible_to_vote?' do
    context 'given a link it can vote on' do
      before do
        @user = Factory :user

        @link = stub 'link'
        @link.
          stubs(:votes).
          returns(Vote)
        @vote = stub 'vote'
        @vote.
          stubs(:user=).
          with(@user)
        @vote.
          stubs(:valid?).
          with().
          returns(true)

        Vote.
          stubs(:new).
          with(:value => @value).
          returns(@vote)
      end

      it 'returns true' do
        @user.should be_eligible_to_vote(@value, :on => @link)
      end
    end
  end

end
