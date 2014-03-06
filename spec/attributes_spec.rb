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

  %w(dev test stage prod).each do |env|
    it "should correctly set the config source file to tilestache-#{env}.conf.erb when env is #{env}" do
      stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
      chef_run.node.set[:mapzen][:environment] = env
      chef_run.converge(described_recipe)

      expect(chef_run.node[:tilestache][:config][:source_file]).to eq("tilestache-#{env}.conf.erb")
    end
  end

end
