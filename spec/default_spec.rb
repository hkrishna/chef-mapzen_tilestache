require 'spec_helper'

describe 'mapzen_tilestache::default' do
  context 'we are assigned layer tilestache' do
    let (:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

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
    let (:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

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
