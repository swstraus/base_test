# Create new directory structure
use_inline_resources

action :create do
  serverRoot = "#{new_resource.serverBase}/#{new_resource.name}"

  ################################################################################
  #
  # Create serverBase, if it doesn't exist - usually /data/servers
  #
  ################################################################################
  directory "#{new_resource.serverBase}" do
    user "root"
    group "root"
    mode "0755"
    action :create
  end
  ################################################################################
  #
  # Create serverRoot, if it doesn't exist - usually /data/servers/<serverRoot>
  #
  ################################################################################
  directory serverRoot do
    user "root"
    group "root"
    mode "0755"
    action :create
  end

  ################################################################################
  #
  # Create all files/directories/links under serverRoot
  #
  ################################################################################
  server_dirs = [ "lib", "logs", "temp", "webapps", "work", "etc"]

  server_dirs.each do |dir|
    directory "#{serverRoot}/#{dir}" do
      user "#{new_resource.runUser}"
      group "#{new_resource.runGroup}"
      mode "0775"
      action :create
      recursive true
    end
  end
  [ "conf", "properties"].each do |dir|
    directory "#{serverRoot}/#{dir}" do
      user "root"
      group "root"
      mode "0775"
      action :create
    end
  end


  #############################################################################
  #
  # Create all files/directories under /data/servers/<$serverRoot>/conf
  #
  #############################################################################

  template "#{serverRoot}/conf/server.xml" do
    cookbook "base_test"
    source "conf/server.xml.erb"
    user "root"
    group "root"
    mode "0664"
  end

    service "crond" do
      supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
      if (new_resource.start == true) && (new_resource.fileChangeRestart == true) && (tomcat_running?(new_resource.runUser))
       new_resource.restartSubscribes.each do |file|
         subscribes :restart, "template[#{serverRoot}/#{file}]"
       end
      end
      if new_resource.enable == true
       if (new_resource.start == true) && !(tomcat_running?(new_resource.runUser)) 
           action [:enable, :start]
        else
           action :enable
         end
       else
         action :disable
       end
    end

end
