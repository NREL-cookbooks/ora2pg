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

archive_filename = "ora2pg-#{node[:ora2pg][:version]}.tar.bz2"
remote_file "#{Chef::Config[:file_cache_path]}/#{archive_filename}" do
  source node[:ora2pg][:url]
  checksum node[:ora2pg][:archive_checksum]
  backup false
end

directory "/etc/ora2pg" do
  mode "0755"
  owner "root"
  group "root"
  recursive true
end

bash "install_ora2pg" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOS
    tar -xvf #{archive_filename}
    cd ora2pg-#{node[:ora2pg][:version]}
    PREFIX=/opt/ora2pg perl Makefile.PL
    make && make install && cp /opt/ora2pg/etc/opt/ora2pg/ora2pg.conf.dist /etc/ora2pg/ && rm -rf /opt/ora2pg/etc
  EOS
  not_if "PERL5LIB=/opt/ora2pg/usr/local/share/perl5:$PERL5LIB /opt/ora2pg/usr/local/bin/ora2pg --version | grep -q 'v#{node[:ora2pg][:version]}$'"
end

template "/etc/ora2pg/ora2pg.conf" do
  source "ora2pg.conf.erb"
  mode "0644"
  owner "root"
  group "root"
end 

template "/etc/profile.d/ora2pg.sh" do
  source "profile.erb"
  mode "0644"
  owner "root"
  group "root"
end
