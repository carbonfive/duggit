require 'spec_helper'

describe 'Routing to links' do
  it 'is routed to from "/"' do
    { :get => '/' }.should route_to(:controller => 'links',
                                    :action => 'index')
  end
end
