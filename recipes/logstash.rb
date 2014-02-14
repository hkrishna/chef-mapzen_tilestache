#
# Cookbook Name:: mapzen_tilestache
# Recipe:: logstash
#

include_recipe 'mapzen_logstash::default'

logstashrc 'logstash-tilestache' do
  template_source 'logstash_tilestache.conf.erb'
  template_cookbook 'mapzen_tilestache'
end

