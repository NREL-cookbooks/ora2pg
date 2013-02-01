#
# Cookbook Name:: ora2pg
# Attributes:: ora2pg
#
# Copyright 2013, NREL
#
# All rights reserved - Do Not Redistribute
#

default[:ora2pg][:version] = "10.1"
default[:ora2pg][:url] = "http://hivelocity.dl.sourceforge.net/project/ora2pg/#{ora2pg[:version]}/ora2pg-#{ora2pg[:version]}.tar.bz2"
default[:ora2pg][:archive_checksum] = "126a166967018c881d9788a215aba29df1058b1eb92fa07e2c3f1df348121246"
