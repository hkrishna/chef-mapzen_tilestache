require 'spec_helper'

describe 'mapzen_tilestache::default' do
  %w(dev test stage prod).each do |env|
    let (:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:mapzen][:environment] = env
        node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
        node.set[:opsworks][:stack][:name] = 'stack::name'
        node.set[:opsworks][:instance][:layers] = %w(tilestache)
        node.set[:opsworks][:instance][:region] = 'us-east-1'
      end.converge(described_recipe)
    end

    it "should correctly set the configuration file for env #{env}" do
      expect(chef_run.node[:tilestache][:config][:source_file]).to eq(env)
    end

  end
    
  context 'we are assigned layer tilestache' do
    let (:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:mapzen][:environment] = 'test'
        node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
        node.set[:opsworks][:stack][:name] = 'stack::name'
        node.set[:opsworks][:instance][:layers] = %w(tilestache)
        node.set[:opsworks][:instance][:region] = 'us-east-1'
      end.converge(described_recipe)
    end

    %w(
      tilestache::default
      mapzen_tilestache::queries
      mapzen_tilestache::sensu
      mapzen_tilestache::logstash
    ).each do |recipe|
      it "should include recipe #{recipe}" do
        stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
        chef_run.should include_recipe recipe
      end
    end

  end

  context 'we are not assigned layer tilestache do' do
    let (:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:mapzen][:environment] = 'test'
        node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
        node.set[:opsworks][:stack][:name] = 'stack::name'
        node.set[:opsworks][:instance][:layers] = %w()
        node.set[:opsworks][:instance][:region] = 'us-east-1'
      end.converge(described_recipe)
    end

    %w(
      tilestache::default
      mapzen_tilestache::queries
      mapzen_tilestache::sensu
      mapzen_tilestache::logstash
    ).each do |recipe|
      it "should not include recipe #{recipe}" do
        stub_command("test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar").and_return(true)
        chef_run.should_not include_recipe recipe
      end
    end

  end

end
