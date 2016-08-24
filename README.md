# Vagrant dependency manager

[![Join the chat at https://gitter.im/DevNIX/Vagrant-dependency-manager](https://badges.gitter.im/DevNIX/Vagrant-dependency-manager.svg)](https://gitter.im/DevNIX/Vagrant-dependency-manager?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

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

require File.dirname(__FILE__)+"./dependency_manager"

check_plugins ["vagrant-exec", "vagrant-hostsupdater", "vagrant-cachier", "vagrant-triggers"]

Vagrant.configure(2) do |config|

  config.vm.box = "base"

end
```

### Invoking

Just `vagrant up` or `vagrant reload` as usual!

_**Danger:** this is so easy to use that you could forget that you are checking for missing dependencies every time you bootstrap your machine :D_

#### Bypass the dependency manager

You might want to skip the dependency manager proccess that runs just before Vagrant. If it's your case, you can up your Vagrant machine as always with the `--skip-dependency-manager`` parameter before the Vagrant command.

Example:
```
vagrant --skip-dependency-manager up
```

_Remember: if you type the vagrant command before the `--skip-dependency-manager` paramter you will get an error because Vagrant tries to run an invalid option_
