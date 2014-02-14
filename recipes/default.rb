#
# Cookbook Name:: mapzen_tilestache
# Recipe:: default
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

# stuff we want to install
recipes = %w(
  tilestache::default
  mapzen_tilestache::queries
  mapzen_tilestache::sensu
  mapzen_tilestache::logstash
)

# layers we'll permit execution on
layers = %w(
  tilestache
)

if node[:opsworks]
  layers.each do |layer|
    if node[:opsworks][:instance][:layers].include? layer
      recipes.each do |recipe|
        include_recipe recipe
      end
      break
    else
      log "#{node[:hostname]} is not assigned layer #{layer}. Not applying any recipes on this loop."
    end
  end

# match vagrant for test
elsif node[:hostname] =~ /^vagrant-/
  recipes.each do |recipe|
    include_recipe recipe
  end
else
  log "Not applying cookbook. See recipes/default.rb!"
end
