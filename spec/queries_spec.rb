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

  it 'should sync the vector-datasource git repository' do
    chef_run.should sync_git('/etc/tilestache/osrm-vector-queries').with(
      repository: 'https://github.com/mapzen/vector-datasource.git',
      reference:  'master',
      user:       'tilestache',
      group:      'tilestache'
    )
  end

  it 'should restart service tilestache immediately' do
    git = chef_run.git('https://github.com/mapzen/vector-datasource.git')
    execpt(git).to notify('service[tilestache]').to(:restart).immediately
  end

end
