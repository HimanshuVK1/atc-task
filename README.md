<img width="1440" alt="image" src="https://github.com/user-attachments/assets/768aa2ed-21c3-42c3-9ddc-71ca6d4408f4" /># atc-task

Cloud & DevOps Engineer Assessment Task
Overview
Deploy a web application in a cloud-based Kubernetes solution, ensuring proper logging and monitoring are in place.

Application Functionality
The web application shall have a simple static page of content.

Expected Outcome
Your solution should contain the following items.
·    IAC templates (preferably terraform) used to provision the cloud infrastructure.
·    Kubernetes deployment files.
·    Monitoring solution configuration (preferably Prometheus).
·    Dockerfile that was used to containerize the sample web application.
·    Clear documentation on how to deploy your solution.

--------------------------------------------------------------------------------------------------------------------------------------------
To Do this:
1st Create a Service account on Google and Download it's key.json file into your local.
--------------------------------------------------------------------------------------------------------------------------------------------

2nd install "gcloud" & login-in into your GCP account.
--------------------------------------------------------------------------------------------------------------------------------------------

3nd install terraform.
--------------------------------------------------------------------------------------------------------------------------------------------

4th create "main.tf" and edit it to create gcp gke cluster and this file is persnet at this "assignment/terraform/main.tf" path of this repo.
  - Now run "terraform init" command.
  - then run "terraform plan" command.
  - then run "terraform apply" command.
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/86484c31-c167-40cd-919c-f90fdb3b45de" />
--------------------------------------------------------------------------------------------------------------------------------------------

5th install "kubectl" in you local.
  - Now connect with GKE cloud.
  - And run "kubectl cluster-info" command to check connectivity with gke cluster.
  - <img width="902" alt="image" src="https://github.com/user-attachments/assets/d7949ff8-86bd-49bb-b799-b58d7957eb05" />
--------------------------------------------------------------------------------------------------------------------------------------------

6th install "helm" on you local.
--------------------------------------------------------------------------------------------------------------------------------------------

7th run "kubectl create namespace monitor" command to create new namespace in your cluster where we will deploy "prometheus, node-expoter, grafana, loki & promtail.
--------------------------------------------------------------------------------------------------------------------------------------------

8th instll "kube prometheus stack" with helm on you Cluster to monitor Resource utilization of CPU, Memory, Storage & Netwrok etc.
  - helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  - helm repo update
  - Edit "assignment/gke/monitoring/kube_prometheus_stack.yaml" helm value file of prometheus stack as per your need.
  - Now intall with below helm command.
  - helm upgrade --install --namespace monitor prometheus prometheus-community/kube-prometheus-stack -f kube_prometheus_stack.yaml
--------------------------------------------------------------------------------------------------------------------------------------------

9th install "loki stack" with helm on you Cluster to collect logs of all the pod which are running in cluster. 
  - helm repo add grafana https://grafana.github.io/helm-charts
  - helm repo update
  - Edit "assignment/gke/monitoring/loki-custom-values.yaml" helm value file of loki stack as per your need.
  - Now intall with below helm command.
  - helm upgrade --install --values loki-custom-values.yaml loki grafana/loki-stack --set loki.image.tag=2.9.3 -n monitor
--------------------------------------------------------------------------------------------------------------------------------------------

10th Check all the pods with "kubectl get pods -n monitor" and all service with "kubectl get svc -n monitor" command in "monitor" namespace.
  - pods
<img width="552" alt="image" src="https://github.com/user-attachments/assets/0e80421e-dc8f-41bd-9d00-ab1141b40184" />

  - services
<img width="814" alt="image" src="https://github.com/user-attachments/assets/fa97fcb0-d337-4251-a8ad-e172143cbb53" />

11th now edit service of grafan and chenge it type form ClusterIP to LoadBalancer so we can access it publicly on internet.
  - Run "kubectl edit svc prometheus-grafana -n monitor" command and edit it state file.
  - this will provide a loadbalancer Public IP.
  - Now access this ip on you bwoser.
  - Then run  "kubectl get secret --namespace monitor prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo"  this command to get grafana password for admin login.
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/438b003a-ab9a-45bc-92f8-c1e7f4294728" />
--------------------------------------------------------------------------------------------------------------------------------------------

12th Now Add Prmetheus endpoint to you Datasource of Grafana.
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/3fe28296-fad2-4c96-b7c2-e090929fb547" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/eaa8f1ca-a638-4331-81a6-b397741e1873" />
--------------------------------------------------------------------------------------------------------------------------------------------

13th Now Add Loki endpoint to you Datasource of Grafana.
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/a4d14f2e-0a3c-4d42-ab6a-c4ada1be7a75" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/646e4bea-fe3a-4d90-b4a4-911cdffc4d46" />
--------------------------------------------------------------------------------------------------------------------------------------------

14th Now create Dockerfile for you webapp image with this file "assignment/gke/Dockerfile" is present in this repo.
  - Install Docker on your local and Login with your Docker Hub Account.
  - Create a docker image via Dockerfile with "docker build -t himanshu369/webapp:v1.0.4 -f Dockerfile ." command.
  - Push it to you Docker Hub with "docker push himanshu369/webapp:v1.0.4".
--------------------------------------------------------------------------------------------------------------------------------------------

15th Now creat Deployment and Service file for your Kubernetes Cluster with this file "assignment/gke/webapp.yaml" in present in this repo.
  - Deploy this Deployment and service with "kubectl apply -f webapp.yaml" command in default namespace.
<img width="655" alt="image" src="https://github.com/user-attachments/assets/5a263ee6-55e6-4a34-baac-d31757a890b7" />
--------------------------------------------------------------------------------------------------------------------------------------------

16th Now Copy web-app-service loadbalancer ip address and past it in you browser and hit this ip.
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/d4f4ed4a-5fea-4d86-bcac-ecfb3d556600" />
--------------------------------------------------------------------------------------------------------------------------------------------

17th Now to check Logs of webapp deployment pods go to Grafana Dashboard --> Explore --> Choose Loki Data source picker and Check your logs.
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/097a9ade-5107-4d6a-a916-b99feb982570" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/636251b6-db20-4df9-b432-1c743e647b73" />
--------------------------------------------------------------------------------------------------------------------------------------------

18th Now to check resource utilizations of all the deploment and node.
    1) Go to Grafana Dashboard
    2) Select Dashboard "Kubernetes / Compute Resources / Namespace (Workloads)".
    3) Select Namespace "default" or "monitor".
default namespase
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/525d04bc-328a-4281-8698-eab47f7634b6" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/15d7b446-f8e3-4cbc-9774-8570b7f72280" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/7efef98b-9033-481d-a939-2acbc7f6701d" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/11dc1c4c-7b56-4fee-81ad-1c14938e66c1" />
---
monitor namespace
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/93c9e721-0070-4017-928e-dafcff907bd7" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/d518990e-6767-43a3-aa3f-a091416cfc8b" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/257aa9dc-dec2-4433-8349-e986cb65c195" />
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/ea3976dd-60f9-4155-8532-2d3b7ca9331f" />

--------------------------------------------------------------------------------------------------------------------------------------------

End of Task.







