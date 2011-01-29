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

    context 'when trying to vote twice on the same link' do
      before do
        user = Factory :user
        link = Factory :link
        Factory :vote, :user => user, :link => link

        @vote = Factory.build :vote, :user => user, :link => link
      end

      it 'fails' do
        @vote.should_not be_valid
      end
    end

    context 'when trying to vote on your own link' do
      before do
        user = Factory :user
        link = Factory :link, :author => user

        @vote = Factory.build :vote, :user => user, :link => link
      end

      it 'fails' do
        @vote.should_not be_valid
      end
    end
  end
  
end
