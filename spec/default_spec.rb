require 'spec_helper'

describe 'mapzen_tilestache::default' do
  context 'we are assigned layer tilestache' do
    let (:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:mapzen][:environment] = 'test'
        node.set[:mapzen][:postgresql][:endpoint = 'localhost'
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
        chef_run.should include_recipe recipe
      end
    end

  end

  context 'we are not assigned layer tilestache do' do
    let (:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:mapzen][:environment] = 'test'
        node.set[:mapzen][:postgresql][:endpoint = 'localhost'
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
      it "should not include recipe #{recipe}" do
        chef_run.should_not include_recipe recipe
      end
    end

  end

end
