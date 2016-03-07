# Vagrant dependency manager
Simple snippet that allows you to define a list of plugins in your Vagrantfile, and manage them as dependencies.

I am not a Ruby programmer (yet) and this is a young software, so any issues and pull requests are always welcome! 

## Installation

Just clone this package on the folder you will always do `vagrant up`, or just paste `dependency_manager.rb` on that directory.

## Usage

Include `dependency_manager.rb` in your Vagrantfile and call the function `check_plugins` with an array of plugin names.

`Vagrant dependency manager` will check if the named plugins are installed. If they are the boot will continue as always. If a plugin is not installed, it will perform a `vagrant plugin install 'packagename'` and continue. If the package does not exists or there is a problem with the installation, the application will exit with an error code.

### Example

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

require "./dependency_manager"

check_plugins ["vagrant-exec", "vagrant-hostsupdater", "vagrant-cachier", "vagrant-triggers"]

Vagrant.configure(2) do |config|

  config.vm.box = "base"

end
```
