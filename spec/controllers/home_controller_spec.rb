require 'spec_helper'

describe HomeController do

  describe '#index' do
    context 'given 30+ links in the system' do
      before do
        (1..40).each do |i|
          Link.create :title => i.to_s, :url => 'http://www.carbonfive.com'
        end

        get :index
        @links = assigns(:links)
      end

      it 'should get the last 30 links in reverse chronological order' do
        @links.collect(&:title).should == (11..40).to_a.reverse.collect(&:to_s)
      end

      it 'should go to the home page' do
        response.should render_template(:index)
      end
    end
  end

end
