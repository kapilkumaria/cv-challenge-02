## Automate Deployment with Terraform and Ansible - Full Stack Application with Monitoring and Logging

This project focuses on automating the deployment of a full-stack application and its associated monitoring and logging infrastructure using Terraform and Ansible. The workflow ensures seamless provisioning, configuration, and deployment of application and monitoring stacks with path-based routing, SSL certificate management, and DNS updates.

Key improvements over previous iterations include full automation of infrastructure and deployment processes. The same application source code from Week 1 is utilized, but the setup is fully automated to reduce manual intervention and enhance scalability and reproducibility.

## Objectives

Automate infrastructure provisioning using Terraform to manage compute, networking, and DNS resources on AWS.
Streamline application and monitoring stack deployment using Ansible, organized into modular roles (e.g., application, database, monitoring, Traefik, nginx, common).
Ensure secure routing with Traefik, including SSL certificate issuance and DNS A-record updates for public IPs.
Use prebuilt Docker images for the application stack, stored in Docker Hub, for faster deployments.
Provide a single command deployment workflow:

```
terraform apply --auto-approve
```
### **Components** 
--- 
#### **1. Infrastructure Provisioning (Terraform)**

- **Compute Resources**: AWS EC2 instances for hosting the application and monitoring stacks.
- **Networking Resources**: Configures VPC, subnets, security groups, and internet gateways.
- **DNS Management**: Adds A-record entries in AWS Route53 pointing to EC2 public IPs.
- **Integration with Ansible**:
  1. Dynamically generates inventory.ini files.
  2. Triggers Ansible playbooks post-provisioning.

#### **2. Application Stack**
- **Frontend:** React-based user interface.
- **Backend:** FastAPI for handling API requests.
- **Database:** PostgreSQL for persistent data storage.
- **Reverse Proxy:** Traefik for path-based routing between services and SSL management.

> You must prebuild the Docker images for the **Frontend** and **Backend** and push them to your public Docker Hub repositories:
Reference: We built docker images and pushed that to DockerHub in https://github.com/kapilkumaria/cv-challenge01

- Example frontend image: `docker.io/<your_username>/frontend:latest`  
- Example backend image: `docker.io/<your_username>/backend:latest`  

The application stack Ansible role will pull these images from Docker Hub.

---

#### **3. Monitoring Stack**
- **Prometheus** Collects and stores application metrics.
- **Grafana** Provides visualizations with preconfigured dashboards for cAdvisor and Loki.
- **cAdvisor** Monitors container-level metrics.
- **Loki** Aggregates logs from the application and system.
- **Promtail** Collects logs from the application and system.
---

#### **4. Deployment Workflow**
- **Terraform:**  
  - Provisions the cloud infrastructure (e.g., server instance, networking).
  - Generates the Ansible inventory file (`inventory.ini`) dynamically.  
  - Triggers Ansible playbooks.  

- **Ansible:**  
  - Configures the server environment.  
  - Creates a shared Docker network.  
  - Deploys the application and monitoring stacks by pulling prebuilt images from Docker Hub and running them via Docker Compose.  
  - Configures Traefik or Nginx for routing across all services.

---

## Project Structure

The project is organized into the following structure:

- ansible/: Contains playbooks, inventory files, and modular roles for deploying the application and monitoring stacks. Each role is designed to handle specific components, ensuring reusability and clarity.

- terraform/: Contains the configuration files for provisioning cloud infrastructure. It automates the creation of compute instances, networking resources, and DNS configurations.

---

```
~/cv-challenge-02 main !1 ❯ tree -L 3                                                                         
.
├── README.md
├── README.md.bkp
├── ansible
│   ├── README.md
│   ├── ansible.cfg
│   ├── group_vars
│   ├── inventory
│   ├── roles
│   │   ├── application
│   │   ├── common
│   │   ├── db
│   │   ├── monitoring
│   │   ├── nginx
│   │   └── traefik
│   ├── site.yml
│   └── vault
├── ansible.cfg -> /home/ubuntu/cv-challenge-o2/ansible/ansible.cfg
├── images
│   └── ansible-folders.png
└── terraform
    ├── backend
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── terraform.tfstate
    │   ├── terraform.tfstate.backup
    │   └── variables.tf
    ├── backend.tf
    ├── environments
    │   ├── dev.tfvars
    │   ├── prod.tfvars
    │   └── staging.tfvars
    ├── main.tf
    ├── modules
    │   ├── compute
    │   └── network
    ├── outputs.tf
    └── variables.tf
```
---

```
~/cv-challenge-02 main !1 ❯ tree ansible
ansible
├── README.md
├── ansible.cfg
├── group_vars
├── inventory
├── roles
│   ├── application
│   │   ├── defaults
│   │   ├── files
│   │   │   ├── backend.env
│   │   │   ├── frontend.env
│   │   │   └── nginx.conf
│   │   ├── handlers
│   │   ├── meta
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   │   └── docker_container.j2
│   │   └── vars
│   ├── common
│   │   └── tasks
│   │       └── main.yml
│   ├── db
│   │   ├── files
│   │   │   └── db.env
│   │   └── tasks
│   │       └── main.yml
│   ├── monitoring
│   │   ├── files
│   │   │   ├── grafana.yml
│   │   │   ├── loki-config.yml
│   │   │   ├── prometheus.yml
│   │   │   └── promtail-config.yml
│   │   ├── handlers
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   ├── nginx
│   │   ├── files
│   │   │   └── nginx.conf
│   │   └── tasks
│   │       └── main.yml
│   └── traefik
│       ├── defaults
│       ├── files
│       │   └── acme.json
│       ├── handlers
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       └── vars
├── site.yml
└── vault
```
---

```
~/cv-challenge-02 main !1 ❯ tree terraform
terraform
├── backend
│   ├── main.tf
│   ├── outputs.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── variables.tf
├── backend.tf
├── environments
│   ├── dev.tfvars
│   ├── prod.tfvars
│   └── staging.tfvars
├── main.tf
├── modules
│   ├── compute
│   │   ├── main.tf
│   │   ├── main.tf.bkp
│   │   ├── outputs.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   └── variables.tf.bkp
│   └── network
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfstate
│       ├── terraform.tfstate.backup
│       └── variables.tf
├── outputs.tf
└── variables.tf
```
# How to Use This Repository

Follow the steps below to set up and deploy the services defined in this repository:

### Step 1: AWS - EC2 Instance Ubuntu, t2.medium with 50GiB Storage Volume

### Step 2: Install Docker and Docker Compose
Ensure Docker and Docker Compose are installed on server

### Step 3: Clone the Repository

Clone this repository to your server to access the application and configuration files.
```
git clone https://github.com/kapilkumaria/cv-challenge02.git
```
### Step 4: Navigate to the Application Directory

Move into the application folder where the main docker-compose.yml file is located.
```
cd cv-challenge01/application
```
### Step 5: Create a Docker Network

Create a Docker network named app_network. This network ensures seamless communication between the containers.
```
docker network create app_network
```
## Step 6: Secure the ACME Configuration

Ensure that the acme.json file (used by Traefik for Let's Encrypt certificates) has the correct permissions for security.
```
chmod 600 cv-challenge01/traefik/letsencrypt/acme.json
```
    Note: Incorrect permissions may prevent Traefik from functioning properly and could expose sensitive certificate data.




























<!-- 2. Ensure your design accounts for:  
   - Shared Docker networks.  
   - Routing between services.  

#### **Step 3: Write Terraform and Ansible Configurations**
1. **Terraform:**  
   - Provision cloud infrastructure (e.g., a VM instance).  
   - Automatically generate the Ansible inventory file (`inventory.ini`).  
   - Trigger Ansible playbooks.  

2. **Ansible:**  
   - Use roles to:
     - Configure the server environment.
     - Set up and run the **Application Stack** (using Docker Compose).
     - Set up and run the **Monitoring Stack** (using Docker Compose).
     - Configure routing with Traefik.

--- -->



### **Test Your Application By**
1. Run:
   ```bash
   terraform apply -auto-approve
   ```
2. This command should:
   - Provision the infrastructure.
   - Automatically deploy both the application and monitoring stacks.
   - Configure routing for all services.  

3. The following will be verified:  
   - Application accessibility through the reverse proxy.  
   - Monitoring dashboards in Grafana (including cAdvisor and Loki).  

---
