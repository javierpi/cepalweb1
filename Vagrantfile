# Primer intento sitio cepal con ubuntu 12.04 (presice) 32
#
domain   = 'cepal.org'

nodes = [
  { :hostname => 'db',  :ram => '256',     :ip => '192.168.0.43', :box => 'precise32' },
  { :hostname => 'web', :ram => '256',     :ip => '192.168.0.44', :box => 'precise32' },
]


Vagrant.configure("2") do |config|
  #config.vm.provider "virtualbox" do |vb|
  #  vb.cpus = 1
  #end
  

  
  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.host_name = node[:hostname] + '.' + domain
      node_config.vm.network "private_network", ip: node[:ip]
      
      #node_config.vm.customize ['modifyvm', :id, '--cpuexecutioncap', '50']
      
      node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "256"]
        vb.customize ["modifyvm", :id, "--cpus", "1"]   
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]   
      end  
      
      #mymemory = node[:ram] ? node[:ram] : 256;
      #node_config.vm.memory = 256
      #node_config.vm.customize [
      #  'modifyvm', :id,
      #  '--name', node[:hostname],
      #  '--memory', mymemory.to_s
      #]
    end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'puppet/modules'
  end

end

#Vagrant.configure(2) do |config|
  
#  nodes.each do |node|
#    config.vm.define node[:hostname] do |node_config|
#      node_config.vm.box = node[:box]
#      node_config.vm.host_name = node[:hostname] + '.' + domain
#      node_config.vm.network :hostonly, node[:ip]

 #     memory = node[:ram] ? node[:ram] : 256;
 #     node_config.vm.customize [
 #       'modifyvm', :id,
 #       '--name', node[:hostname],
 #       '--memory', memory.to_s
 #     ]
 #   end
 # end

 # c
 
#end
