keyspace = Rails.env.test? ? 'duggit_test' : 'duggit_development'
servers = [ '127.0.0.1:9160' ]
thrift = { :timeout => 3, :retries => 2 }
$cassandra = Cassandra.new keyspace, servers, thrift