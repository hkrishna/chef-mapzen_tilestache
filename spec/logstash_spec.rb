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

  it 'should include recipe mapzen_logstash' do
    stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
    chef_run.should include_recipe 'mapzen_logstash::default'
  end

  it 'should create template /opt/logstash/conf.d/logstash-tilestache.conf' do
    stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
    chef_run.should create_template('/opt/logstash/conf.d/logstash-tilestache.conf').with(
      source: 'logstash_tilestache.conf.erb',
      cookbook: 'mapzen_tilestache'
    )
  end

end
