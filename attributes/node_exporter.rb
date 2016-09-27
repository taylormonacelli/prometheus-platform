#
# Copyright (c) 2016 Sam4Mobile
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

default['prometheus-platform']['node_version'] = '0.12.0'
prometheus_node_version = node['prometheus-platform']['node_version']

# Where to get the tarball for prometheus node exporter
default['prometheus-platform']['node_mirror_base'] =
  'https://github.com/prometheus/node_exporter/releases/download/'
node.default['prometheus-platform']['node_checksum'] =
  'd48de5b89dac04aca751177afaa9b0919e5b3d389364d40160babc00d63aac7b'
prometheus_mirror = node['prometheus-platform']['node_mirror_base']
node_package_name =
  "node_exporter-#{prometheus_node_version}.linux-amd64.tar.gz"
default['prometheus-platform']['node_mirror'] =
  "#{prometheus_mirror}/#{prometheus_node_version}/#{node_package_name}"