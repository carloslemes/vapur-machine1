# vapur-machine1.pp
# Puppet script of my first Vagrant-Puppet machine. 
group { 'puppet': ensure => 'present' }

# Set the MOTD
file { "/etc/motd":
	ensure 	=> file,
	content => "Welcome to the vapur-machine1 virtual machine. 

  Environment info:
 
	- Ubuntu 12.04.2 LTS (GNU/Linux 3.5.0-23-generic x86_64) 
	- Apache (Ubuntu repository version)
	- Passenger 3.0.12
	- Ruby 1.9.1
	- Sinatra gem
 
  Work hard and work smart.
 "
}

# Update apt's package list
exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

# GCC module used to build passenger
include gcc

# Declare Apache
#class {'apache':
#	purge_vdir 	=> false,
#}

file { "/etc/apache2/sites-enabled/000-default":
	ensure	=> absent,
}

# Declare Passenger, it does need parameters because I'm
# using ruby 1.9.1 instead of default. 
class {'passenger':
  passenger_version      => '3.0.12',
  passenger_provider     => 'gem',
  passenger_package      => 'passenger',
  gem_path               => '/opt/ruby/lib/ruby/gems/1.9.1/gems',
  gem_binary_path        => '/opt/ruby/bin',
  mod_passenger_location => '/opt/ruby/lib/ruby/gems/1.9.1/gems/passenger-3.0.12/ext/apache2/mod_passenger.so',
	notify								 => Service['httpd'],
}

apache::vhost { 'default':
    priority        => '000',
    vhost_name      => '*',
    port            => '80',
    docroot         => '/var/www/public',
    serveradmin     => 'thisisatestmachine@example.com',
}

file { "/var/www":
	ensure 	=> link,
	target 	=> '/vagrant_data',
	notify	=> Service['httpd'],
}

# Passenger looks for ruby on /usr/bin directory (see template passenger-load.erb),
# but it is located on another path at the VM
file { "ruby":
  path 		=> "/usr/bin/ruby",
	ensure 	=> link,
	target 	=> "/opt/ruby/bin/ruby",
}

# Install sinatra framework as a gem
package { 'sinatra':
    ensure   => 'installed',
    provider => 'gem',
}