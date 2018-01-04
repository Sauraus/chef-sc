# frozen_string_literal: true

#
# Cookbook Name:: sc
# Attribute:: default
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

# You can choose 'latest' as version, but keep in mind that whenever Saucelabs does a new release, your proxy will restart!
default['sc']['server']['version'] = '4.4.11'
default['sc']['server']['download_url'] = 'http://saucelabs.com/downloads'
default['sc']['server']['tarball'] = "sc-#{node['sc']['server']['version']}-linux.tar.gz"
default['sc']['server']['checksum'] = 'b61557580d3496f80421914af897b583ed1117493643fc991f7d6ee5c79b46ee'

default['sc']['server']['ports'] = ['4445']

# NOTE: We do not deep merge these in the recipe eg. you must include these in your override if you need these.
default['sc']['server']['cmd_options'] =
  ['--se-port "%i"',
   '--logfile -'
  ]

# Typically overridden in the policy file
default['sc']['server']['api_user'] = nil
default['sc']['server']['api_key'] = nil
