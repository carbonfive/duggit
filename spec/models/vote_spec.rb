require 'spec_helper'

describe Vote do

  describe '#valid?' do
    context 'given a vote without a user' do
      before do
        @vote = Factory.build :vote, :user => nil
      end

      it 'fails' do
        @vote.should_not be_valid
      end
    end

    context 'given a vote without a link' do
      before do
        @vote = Factory.build :vote, :link => nil
      end

      it 'fails' do
        @vote.should_not be_valid
      end
    end

    context 'given a vote with an invalid value' do
      before do
        @vote = Factory.build :vote, :value => 2
      end

      it 'fails' do
        @vote.should_not be_valid
      end
    end

    [-1, 1].each do |value|
      context "given a vote with a value of #{value}" do
        before do
          @vote = Factory.build :vote, :value => value
        end

        it 'passes' do
          @vote.should be_valid
        end
      end
    end

    context 'given a vote on a link the user submitted' do
      before do
        user = Factory :user
        link = Factory :link, :author => user

        @vote = Factory.build :vote, :user => user, :link => link
      end

      it 'fails' do
        @vote.should_not be_valid
      end
    end

    context 'given a vote identical to one the user has already made' do
      before do
        user = Factory :user
        link = Factory :link
        Factory :up_vote, :user => user, :link => link

        @vote = Factory.build :up_vote, :user => user, :link => link
      end

      it 'fails' do
        @vote.should_not be_valid
      end
    end

    context 'given an up-vote for a link the user already cast a down-vote on' do
      before do
        link = Factory :link
        user = Factory :user
        Factory(:down_vote,
                :link => link,
                :user => user)

        @vote = Factory.build :up_vote, :user => user, :link => link
      end

      it 'passes' do
        @vote.should be_valid
      end
    end

    context 'given a down-vote for a link the user already case an up-vote on' do
      before do
        link = Factory :link
        user = Factory :user
        Factory(:up_vote,
                :value => 1,
                :link => link,
                :user => user)

        @vote = Factory.build :down_vote, :user => user, :link => link
      end

      it 'passes' do
        @vote.should be_valid
      end
    end
  end
  
end
