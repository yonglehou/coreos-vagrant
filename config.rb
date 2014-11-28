
# To automatically replace the discovery token on 'vagrant up', uncomment
# the lines below:
#
#if File.exists?('user-data') && ARGV[0].eql?('up')
#  require 'open-uri'
#  require 'yaml'
# 
#  token = open('https://discovery.etcd.io/new').read
# 
#  data = YAML.load(IO.readlines('user-data')[1..-1].join)
#  data['coreos']['etcd']['discovery'] = token
# 
#  yaml = YAML.dump(data)
#  File.open('user-data', 'w') { |file| file.write("#cloud-config\n\n#{yaml}") }
#end
#

#
# coreos-vagrant is configured through a series of configuration
# options (global ruby variables) which are detailed below. To modify
# these options, first copy this file to "config.rb". Then simply
# uncomment the necessary lines, leaving the $, and replace everything
# after the equals sign..

# CoreOS cluster numbers that Vagrant should create - these should be a comma separated string of positive numbers (values should be in the range 1-253)
@instances="1,2,3"

# Official CoreOS channel from which updates should be downloaded
$update_channel='stable'

# Log the serial consoles of CoreOS VMs to log/
# Enable by setting value to true, disable with false
# WARNING: Serial logging is known to result in extremely high CPU usage with
# VirtualBox, so should only be used in debugging situations
#$enable_serial_logging=false

# Enable port forwarding of Docker TCP socket
# Set to the TCP port you want exposed on the *host* machine, default is 2375
# If 2375 is used, Vagrant will auto-increment (e.g. in the case of $num_instances > 1)
# You can then use the docker tool locally by setting the following env var:
#   export DOCKER_HOST='tcp://127.0.0.1:2375'
#$expose_docker_tcp=2375

# Setting for VirtualBox VMs
#$vb_gui = false
$vb_memory = 2048 # 2GB
#$vb_cpus = 1

# Used to determine which Akka container is to be used as the initial cluster seed
@initialSeed = "exercise-1"

# Docker images that our distributed application will use
@docker = {
  :cassandra    => "spotify/cassandra",
  :exercise     => "carlpulley/lift-exercise:v1.0.0-SNAPSHOT",
  :notification => "carlpulley/lift-notification:v1.0.0-SNAPSHOT",
  :profile      => "carlpulley/lift-profile:v1.0.0-SNAPSHOT"
}

# List of service templates that we want on each compute node
@service_templates = [
  "lift/cassandra@.service",
  "lift/exercise@.service",
  "lift/notification@.service",
  "lift/profile@.service"
]

# Authentication information for accessing the Docker repository
@username='USERNAME'
@password='PASSWORD'
@email='EMAIL'

# Token generated by https://discovery.etcd.io/new
@token='96daaaba2c663ebe7505a2119d990608'
