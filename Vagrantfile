# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Usage:
#   $ vagrant plugin install vagrant-google
#   $ vagrant up --provider=google
#   $ vagrant destroy

# Customize these global variables
$GOOGLE_PROJECT_ID = "azim-personal"
$GOOGLE_JSON_KEY_LOCATION = "~/azim-personal-key.json"
$LOCAL_USER = "azim"
$LOCAL_SSH_KEY = "~/.ssh/google_compute_engine"

$PROVISION = <<SCRIPT
#!/bin/bash

set -e
set -o pipefail

# only setup build-essential; handle the rest via makefiles in this repo
apt-get update && apt-get install --yes build-essential

SCRIPT

Vagrant.configure("2") do |config|

  config.vm.provider :google do |google, override|
    override.vm.box = "google/gce"
    override.ssh.username = $LOCAL_USER
    override.ssh.private_key_path = $LOCAL_SSH_KEY
    google.google_project_id = $GOOGLE_PROJECT_ID
    google.google_json_key_location = $GOOGLE_JSON_KEY_LOCATION

    # Override provider defaults
    google.name = "vagrant-server"
    google.image_family = "ubuntu-1804-lts"
    google.machine_type = "n1-standard-4"
    google.zone = "us-central1-a"
    google.disk_type = "pd-ssd"
    google.disk_size = 10

    # Necessary additional variables to set for preemptible VMs
    google.preemptible = true
    google.auto_restart = false
    google.on_host_maintenance = "TERMINATE"
  end

  config.vm.provider "virtualbox" do |vb, override|
    override.vm.box = "ubuntu/bionic64"
    vb.gui = false
    vb.memory = "1024"
  end

  config.vm.define :devserver do |d|
    d.vm.provision :shell, :inline => $PROVISION
    d.vm.synced_folder ".", "/vagrant/dotfiles", type: "rsync"
    d.ssh.forward_agent = true
  end

end
