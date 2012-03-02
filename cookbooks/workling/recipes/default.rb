#
# Cookbook Name:: workling
# Recipe:: default
appname = "assessingparenting1"
if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  run_for_app(appname) do |app_name, data|
    ey_cloud_report "Workling" do
      message "configuring workling"
    end

    directory "/var/run/workling" do
      action :create
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end

    template "/engineyard/bin/workling" do
      source "workling.erb"
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end


    template "/etc/monit.d/workling.#{app_name}.monitrc" do
      source "workling.monitrc.erb"
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      variables({
        :app_name => app_name,
        :user => node[:owner_name]
      })
    end
  end
end
