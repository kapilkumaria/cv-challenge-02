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

![ansible](images/ansible-folders.png)






























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
