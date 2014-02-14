#
# Cookbook Name:: mapzen_tilestache
# Recipe:: queries
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

git node[:mapzen_tilestache][:query_install_path] do
  repository 'https://github.com/mapzen/vector-datasource.git'
  reference 'master'
  action :sync
  user node[:tilestache][:user]
  group node[:tilestache][:group]
  notifies :restart, 'service[tilestache]', :immediately
end
