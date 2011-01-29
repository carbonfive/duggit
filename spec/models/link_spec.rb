require 'spec_helper'

describe Link do

  describe '.recent' do
    before do
      4.times do |n|
        Factory(:link,
                :created_at => n.days.from_now)
      end

      @limit = 3
      @links = Link.recent :limit => @limit
    end

    it 'finds links ordered most recently created first' do
      @links.each_with_index do |link, index|
        if @links[index.succ]
          link.created_at.should be > @links[index.succ].created_at
        end
      end
    end

    it 'finds the given number of links' do
      @links.should have(@limit).links
    end
  end

  describe '#value' do
    before do
      link = Factory :link
      Factory(:vote,
              :link => link,
              :value => 1)
      Factory(:vote,
              :link => link,
              :value => -1)
      Factory(:vote,
              :link => link,
              :value => 1)

      @value = link.value
    end

    it 'returns the the sum of its votes' do
      @value.should == 1
    end
  end

end
