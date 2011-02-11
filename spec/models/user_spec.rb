require 'spec_helper'

describe User do

  describe '#eligible_to_vote?' do
    context 'given a link the user did NOT create' do
      before do
        @user = Factory :user
        @link = Factory :link
      end

      it 'returns true' do
        @user.should be_eligible_to_vote(@link)
      end
    end

    context 'given a link the user did create' do
      before do
        @user = Factory :user
        @link = Factory(:link,
                        :user => @user)
      end

      it 'returns true' do
        @user.should_not be_eligible_to_vote(@link)
      end
    end
  end

end
