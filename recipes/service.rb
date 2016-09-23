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

auto_restart = node['prometheus-platform']['auto_restart']
prefix_home = node['prometheus-platform']['prefix_home']
prometheus_config_filename = node['prometheus-platform']['config_filename']

if node['prometheus-platform']['auto_restart']
  config_files = [
    "#{prefix_home}/prometheus/#{prometheus_config_filename}"
  ].map do |path|
    "template[#{path}]"
  end
else config_files = []
end

systemd_unit 'prometheus_server.service' do
  enabled true
  active true
  masked false
  static false
  content node[cookbook_name]['prometheus_server']['unit']
  triggers_reload true
  action [:create, :enable, :start]
  subscribes :restart, config_files if auto_restart
  only_if { node['prometheus-platform']['master_host'] == node['fqdn'] }
end

# Start alertmanager only if config has been done
unless node['prometheus-platform']['master']['alertmanager']['config'].empty?
  systemd_unit 'prometheus_alertmanager.service' do
    enabled true
    active true
    masked false
    static false
    content node[cookbook_name]['prometheus_alertmanager']['unit']
    triggers_reload true
    action [:create, :enable, :start]
    only_if { node['prometheus-platform']['master']['has_alertmanager'] }
  end
end
