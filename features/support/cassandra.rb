require File.expand_path(File.dirname(__FILE__) + '/env')

Before do
  $cassandra.clear_keyspace!
end