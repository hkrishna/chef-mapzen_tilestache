name             'mapzen_tilestache'
maintainer       'mapzen'
maintainer_email 'grant@mapzen.com'
license          'All rights reserved'
description      'Installs/Configures tilestache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.11.10'

recipe 'mapzen_tilestache', 'Wraps tilestache'

%w{
  tilestache
  mapzen_logstash
  mapzen_graphite
  mapzen_sensu_clients
}.each do |dep|
  depends dep
end

%w{ ubuntu }.each do |os|
  supports os
end
