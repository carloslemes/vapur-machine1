# mbhome.pp
group { 'puppet': ensure => 'present' }

# Set thee MOTD
file { "/etc/motd":
	ensure 	=> file,
	content => "Welcome to Ubuntu 12.04.2 LTS (GNU/Linux 3.5.0-23-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
 
 This is the mbhome virtual machine."
}

# Update apt's package list
exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

# Dependencies to build passenger with 
# the command passenger-install-apache2-module
package { "build-essential":
	ensure 	=> installed,
	require => Exec["apt-get update"],	
}

package { "zlib1g-dev":
	ensure => installed,
	require => Exec["apt-get update"],	
}

# Declare Apache, it does not require parameters
#class {'apache':
#	purge_vdir => false,
#}

# Declare Passenger, it does need parameters because I'm
# using ruby 1.9.1 instead of default
class {'passenger':
  passenger_version      => '3.0.12',
  passenger_provider     => 'gem',
  passenger_package      => 'passenger',
  gem_path               => '/opt/ruby/lib/ruby/gems/1.9.1/gems',
  gem_binary_path        => '/opt/ruby/bin',
  mod_passenger_location => '/opt/ruby/lib/ruby/gems/1.9.1/gems/passenger-3.0.12/ext/apache2/mod_passenger.so',
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