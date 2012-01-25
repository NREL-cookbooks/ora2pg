#
# Cookbook Name:: ora2pg
# Recipe:: default
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "oracle_instantclient"
include_recipe "perl::dbd_oracle"
include_recipe "perl::dbd_pg"

rpm = "ora2pg-8.9-1.el6.noarch.rpm"

cookbook_file "#{Chef::Config[:file_cache_path]}/#{rpm}" do
  backup false
end

package "ora2pg" do
  source "#{Chef::Config[:file_cache_path]}/#{rpm}"
  options "--nogpgcheck" 
end

template "/etc/ora2pg/ora2pg.conf" do
  source "ora2pg.conf.erb"
  mode "0644"
  owner "root"
  group "root"
end 
