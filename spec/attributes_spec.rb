require 'spec_helper'

describe 'mapzen_tilestache::default' do
  let (:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
      node.set[:opsworks][:stack][:name]        = 'stack::name'
      node.set[:opsworks][:instance][:layers]   = %w(tilestache)
      node.set[:opsworks][:instance][:region]   = 'us-east-1'
    end
  end

  it "should correctly set the config source file to tilestache-test.conf.erb when env is test" do
    chef_run.node.set[:mapzen][:environment] = 'test'
    chef_run.converge(described_recipe)

    stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
    expect(chef_run.node[:tilestache][:config][:source_file]).to eq("tilestache-#{env}.conf.erb")
  end

end
