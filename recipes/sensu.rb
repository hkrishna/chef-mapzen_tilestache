#
# Cookbook Name:: mapzen_tilestache
# Recipe:: sensu
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mapzen_sensu_clients'

sensu_check "tilestache_#{node[:mapzen][:environment]}_service" do
  command "/etc/sensu/plugins/system/check-http.rb -u http://localhost:#{node[:tilestache][:apache][:port]}/vector/ -q TileStache"
  handlers ["default"]
  standalone true
  interval 30
  additional(:occurrences => 3, :refresh => 3600)
end

