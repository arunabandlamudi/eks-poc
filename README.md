# eks

aws eks update-kubeconfig --name POC-eks --region us-east-1 --profile terraform #update kube config file


kubectl patch deployment coredns -n kube-system --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]' # patch the coredns in the kubesystem namespace

kubectl apply -f k8s/deployment.yml # create deployment

kubectl apply -f k8s/service.yml #create service

kubectl get pods -n nginx-namespace #check the pods

kubectl get svc -n nginx-namespace #check the services

kubectl get all  # Great! We see 1 deployments with 1 pods each with our NGINX service up and running!

curl localhost:30052

Welcome! This is Deployment one, acting as the home 🏡 decor website for poc.

Access the page using LB url.

----------------------------------------------------------------------------------------------
sudo apt-get install wget
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg
sudo apt-get install apt-transport-https
echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install logstash


vim /etc/logstash/conf.d/apachelog.conf
input {
  file {
    path => "/var/log/apache2/access.log"
    start_position => "beginning"
  }
}

filter {
    grok {
  date {
    match => [ "timestamp" , "dd/MMM/yyyy:HH:mm:ss Z" ]
  }
}

output {
  elasticsearch {
    hosts => ["AWS opensearch endpoint"]
    user => 'AWS opensearch username'
    password => 'password'
  }
  stdout { codec => rubydebug }
}


sudo service logstash start
sudo service logstash status

--------------------------------------------------------

Login into kibana 

Discover --> index patterns --> rubydebug --> next step --> timestamp --> create index pattern.
