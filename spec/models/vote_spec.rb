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
  end
end