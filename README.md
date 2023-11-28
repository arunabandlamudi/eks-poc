# eks

{1} create eks cluster using terraform and deploy nginx pod on it:
-------------------------------------------------------------------

aws eks update-kubeconfig --name POC-eks --region ap-south-1 --profile terraform #update kube config file


kubectl patch deployment coredns -n nginx-namespace --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]' # patch the coredns in the nginx namespace

kubectl apply -f k8s/deployment.yml # create deployment

kubectl apply -f k8s/service.yml #create service

kubectl get pods -n nginx-namespace #check the pods

kubectl get svc -n nginx-namespace #check the services

kubectl get all  # Great! We see 1 deployments with 1 pods each with our NGINX service up and running!

Access the nginx page using LB url.

welcome to nginx!

----------------------------------------------------------------------------------------------
{2} create opensearch service using aws console :
------------------------------------------------------------------------------------------
you will get opensearch and kibana
access them from browser

{3} install and configure logstatsh in EKS cluster pod :
--------------------------------------------------------

Install logstash in pod which is running eks:
Reference Link: https://www.elastic.co/guide/en/logstash/current/installing-logstash.html

1. sudo apt-get install wget

2. wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg

3. sudo apt-get install apt-transport-https

4. echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list

5.sudo apt-get update && sudo apt-get install logstash

6. create a logstash configuration file:
   
  vim  /etc/logstash/conf.d/nginx.conf
input {  
file {  
path => "/var/log/nginx/access.log"  
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
hosts => ["***"]  
user => '****'  
password => '****'  
}  
stdout { codec => nginx_logs }  
stdin { codec => rubydebug }
}
}


7. cd /usr/share/logstash
run this cmd inside pod where you installed logstash:
sudo bin/logstash -f /etc/logstash/conf.d/nginx.conf

--------------------------------------------------------

{4} Login into kibana :
---------------------
Dev tools -->run this cmd: GET _cat/indices --> output: "nginx_logs" indices is created
Dev tool --> GET nginx_log/_search --> output:logs are there

another way:
Discover --> index patterns --> nginx_logs --> next step --> timestamp --> create index pattern.
