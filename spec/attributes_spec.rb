require 'spec_helper'

describe 'mapzen_tilestache::default' do
  %w(dev test stage prod).each do |env|
    let (:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:mapzen][:environment]           = env
        node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
        node.set[:opsworks][:stack][:name]        = 'stack::name'
        node.set[:opsworks][:instance][:layers]   = %w(tilestache)
        node.set[:opsworks][:instance][:region]   = 'us-east-1'
      end.converge(described_recipe)
    end

    it "should correctly set the config source file to tilestache-#{env}.conf.erb" do
      expect(chef_run.node[:tilestache][:config][:source_file]).to eq("tilestache-#{env}.conf.erb")
    end
  end

end
