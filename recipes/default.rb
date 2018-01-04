# frozen_string_literal: true

#
# Cookbook Name:: sc
# Recipe:: default
#
# Copyright 2018, Roblox Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['sc']['server']['api_user'].nil? || node['sc']['server']['api_key'].nil?
  raise "Node attribute(s) default['sc']['server']['api_user'] and/or default['sc']['server']['api_key'] not set"
end

ark 'sc' do
  url "#{node['sc']['server']['download_url']}/#{node['sc']['server']['tarball']}"
  version node['sc']['server']['version']
  checksum node['sc']['server']['checksum']
  has_binaries ['bin/sc']
  action :install
end

cookbook_file '/etc/systemd/system/sc.service' do
  action :create
  source 'sc.service'
  mode '00644'
  notifies :restart, 'service[sc]', :delayed
end

# The Chef (13.6.4) systemd_unit resource does cannot render this file, it fails on validation errors thus we drop it
# as a template instead.
template '/etc/systemd/system/sc@.service' do
  action :create
  source 'sc@.service.erb'
  mode '00644'
  variables({
    sauce_username: node['sc']['server']['api_user'],
    sauce_access_key: node['sc']['server']['api_key'],
    sc_cmd_options: node['sc']['server']['cmd_options']
             })
  notifies :restart, 'service[sc]', :delayed
end

directory '/etc/systemd/system/sc.service.wants' do
  action :create
end

node['sc']['server']['ports'].each do |port|
  link "/etc/systemd/system/sc.service.wants/sc@#{port}.service" do
    to '/etc/systemd/system/sc@.service'
    notifies :restart, 'service[sc]', :delayed
  end
end

service 'sc' do
  action [:start, :enable]
end
