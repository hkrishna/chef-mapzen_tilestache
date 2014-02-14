# configs
#
default[:tilestache][:config][:source_cookbook] = 'mapzen_tilestache'
case node[:mapzen][:environment]
when 'dev'
  default[:tilestache][:config][:source_file] = 'tilestache-dev.conf.erb'
when 'test'
  default[:tilestache][:config][:source_file] = 'tilestache-test.conf.erb'
when 'stage'
  default[:tilestache][:config][:source_file] = 'tilestache-stage.conf.erb'
when 'prod'
  default[:tilestache][:config][:source_file] = 'tilestache-prod.conf.erb'
end

# endpoint
#
default[:tilestache][:postgresql_endpoint]  = node[:mapzen][:postgresql][:endpoint]

# apache
#
default[:apache][:listen_ports]           = [ 8080 ]
default[:tilestache][:apache][:port]      = 8080
default[:tilestache][:apache][:base_uri]  = '/vector/'

# queries
#
default[:mapzen_tilestache][:query_dir_name]      = 'osm-vector-queries'
default[:mapzen_tilestache][:query_install_path]  = "#{node[:tilestache][:cfg_path]}/#{node[:mapzen_tilestache][:query_dir_name]}"

# expire
#
default[:mapzen_tilestache][:max_age] = 3600

