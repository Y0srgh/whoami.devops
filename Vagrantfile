Vagrant.configure("2") do |config|
    config.vm.define "jenkins" do |jenkins|
      jenkins.vm.box = "ubuntu/focal64"
      jenkins.vm.network "private_network", ip: "192.168.56.10"
      jenkins.vm.hostname = "jenkins"
      jenkins.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end
      jenkins.vm.provision "shell", inline: <<-SHELL
        sudo apt update
        sudo apt install -y openjdk-11-jdk git
        wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
        echo "deb http://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
        sudo apt update && sudo apt install -y jenkins docker.io
        sudo systemctl enable jenkins && sudo systemctl start jenkins
        sudo usermod -aG docker jenkins
      SHELL
    end
  
    config.vm.define "ansible" do |ansible|
      ansible.vm.box = "ubuntu/focal64"
      ansible.vm.network "private_network", ip: "192.168.56.11"
      ansible.vm.hostname = "ansible"
      ansible.vm.synced_folder "./ansible", "/home/vagrant/ansible"
      ansible.vm.provision "shell", inline: <<-SHELL
        sudo apt update
        sudo apt install -y ansible
      SHELL
    end
  
    config.vm.define "k8s-master" do |master|
      master.vm.box = "ubuntu/focal64"
      master.vm.network "private_network", ip: "192.168.56.12"
      master.vm.hostname = "k8s-master"
      master.vm.synced_folder "./k8s", "/home/vagrant/k8s-master"
      master.vm.provider "virtualbox" do |vb|
        vb.memory = "3072"
        vb.cpus = 2
      end
      master.vm.provision "shell", inline: <<-SHELL
        sudo apt update
        sudo apt install -y docker.io
        curl -sfL https://get.k3s.io | sh -
        sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
      SHELL
    end
  
    config.vm.define "k8s-worker-1" do |worker1|
      worker1.vm.box = "ubuntu/focal64"
      worker1.vm.network "private_network", ip: "192.168.56.13"
      worker1.vm.hostname = "k8s-worker-1"
      worker1.vm.provider "virtualbox" do |vb|
        vb.memory = "1536"
        vb.cpus = 2
      end
      worker1.vm.provision "shell", inline: <<-SHELL
        sudo apt update
        sudo apt install -y docker.io
        curl -sfL https://get.k3s.io | K3S_URL="https://192.168.56.12:6443" K3S_TOKEN="$(cat /vagrant/node-token)" sh -
      SHELL
    end
  end