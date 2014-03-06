require 'spec_helper'

describe 'mapzen_tilestache::default' do
  let (:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:mapzen][:environment] = 'test'
      node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
      node.set[:opsworks][:stack][:name] = 'stack::name'
      node.set[:opsworks][:instance][:layers] = %w(tilestache)
      node.set[:opsworks][:instance][:region] = 'us-east-1'
    end.converge(described_recipe)
  end

  it 'should include recipe mapzen_sensu_clients' do
    stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
    chef_run.should include_recipe 'mapzen_sensu_clients::default'
  end

  it 'should create sensu_check tilestache_test_service' do
    stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
    chef_run.should create_sensu_check('tilestache_test_service').with(
      command: '/etc/sensu/plugins/system/check-http.rb -u http://localhost:8080/vector/ -q TileStache',
      handlers: ['default'],
      standalone: true,
      interval: 30,
      additional: { 'occurrences' => 3, 'refresh' => 3600 }
    )
  end

end
