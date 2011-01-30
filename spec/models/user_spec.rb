require 'spec_helper'

describe User do

  describe '#eligible_to_vote_on?' do
    context 'given a link it submitted' do
      before do
        @user = Factory :user
        @link = Factory(:link,
                        :author => @user)
      end

      it 'returns false' do
        @user.should_not be_eligible_to_vote_on(@link)
      end
    end

    context 'given a link it has NOT already voted on' do
      before do
        @link = Factory :link
        @user = Factory :user
      end

      it 'returns true' do
        @user.should be_eligible_to_vote_on(@link)
      end
    end

    context 'given a link it already voted "up" on' do
      context 'and asked if it can vote "down" on it' do
        before do
          @link = Factory :link
          @user = Factory :user
          Factory(:vote,
                  :value => 1,
                  :link => @link,
                  :user => @user)
        end

        it 'returns true' do
          @user.should be_eligible_to_vote_on(@link, :direction => 'down')
        end
      end

      context 'and asked if it can vote "up" on it' do
        before do
          @link = Factory :link
          @user = Factory :user
          Factory(:vote,
                  :link => @link,
                  :user => @user)
        end

        it 'returns false' do
          @user.should_not be_eligible_to_vote_on(@link, :direction => 'up')
        end
      end
    end
  end

end
