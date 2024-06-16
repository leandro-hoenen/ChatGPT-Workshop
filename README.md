# ChatGPT FHNW Workshop Web App

## Overview

The ChatGPT Workshop App is designed to support students and lecturers during proposed ChatGPT workshops at the FHNW. The app supports workshop participants during the interactive scenarios phase. During the scenarios phase, the app enables lecturers and students to simulate realistic ChatGPT usage scenarios that might occure during their studies at the FHNW. The ChatGPT outputs are rated during the scenarios by the students to train their capabilities on critical thinking while interacting with ChatGPT. The app facilitates the evaluation of various tasks related to scenarios students are guided throught, enhancing critical thinking, media literacy, and the ability to assess information credibility. The app is built with Ruby on Rails, Bootstrap, and PostgreSQL, providing a robust and user-friendly interface.

## Features
### RBAC
Users can register as students or lecturers and have different permissions in the app.
#### User Roles
- **Lecturers**: 
  - Can create, read, update, and delete scenarios and tasks.
  - Can view all evaluations submitted by students for each scenario.
- **Students**: 
  - Can read scenarios and tasks.
  - Can create evaluations for tasks.

### Functionalities

#### User Authentication
- **Devise Integration**: The app uses Devise for user authentication, allowing users to sign up and log in.
- **Role-Based Access Control (RBAC)**: Users can sign up as either lecturers or students. Role-based access ensures that users only have access to the functionalities appropriate for their role.

#### Scenarios
- **CRUD Operations for Lecturers**: Lecturers can create, read, update, and delete scenarios.
- **Viewing Scenarios**: Both lecturers and students can view the list of scenarios. Each scenario includes a detailed description.

#### Tasks
- **CRUD Operations for Lecturers**: Lecturers can create, read, update, and delete tasks associated with scenarios.
- **Viewing Tasks**: Both lecturers and students can view tasks associated with each scenario. Each task includes a detailed description.

#### Evaluations
- **Creating Evaluations (Students)**: Students can create evaluations for tasks. Each evaluation includes:
  - **Accuracy**: A rating and description of the accuracy.
  - **Relevance**: A rating and description of the relevance.
  - **Bias**: A rating and description of the bias.
  - **Comments**: Additional comments from the student.
- **Viewing Evaluations (Lecturers)**: Lecturers can view evaluations submitted by students for each scenario. Evaluations are sorted by tasks and display detailed information including the student's email who submitted the evaluation.

#### Navigation
- **Scenario Index**: Displays a list of all scenarios with options to start, view, edit, or delete (based on user role).
- **Scenario Show**: Displays details of a selected scenario, including its tasks and options to start a scenario or view evaluations (for lecturers).
- **Task Show**: Displays details of a selected task, allowing students to create evaluations.
- **Evaluations View**: Displays all evaluations for a selected scenario, sorted by tasks, date of creation, student's email address, and includes detailed information about each evaluation (for lecturers).

## How to Use

### For Students
1. **Sign Up**: Create an account as a student (Ask your lecturer for a registration key).
2. **View Scenarios**: Browse the available scenarios.
3. **Start a Scenario**: Select a scenario to start and view its tasks (you will be guided through the scenario step by step).
4. **Evaluate Tasks**: Complete the tasks by providing evaluations, including ratings and descriptions for accuracy, relevance, and bias. The tasks and their related evaluations are displayed automatically in a sequence for each started scenario.

### For Lecturers
1. **Sign Up**: Create an account as a lecturer (Ask your application administrator for a registration key).
2. **Manage Scenarios**: Create, update, or delete scenarios.
3. **Manage Tasks**: Create, update, or delete tasks within scenarios.
4. **View Evaluations**: Access the evaluations view for each scenario to see detailed feedback from students.

## Deployment

This guide provides detailed instructions for deploying the ChatGPT Workshop application on an Azure Virtual Machine (VM) using Ubuntu Server, Docker, and Nginx as a reverse proxy.

## Prerequisites

- An Azure account
- Basic knowledge of SSH and command line operations
- Docker and Nginx installation knowledge

## Step 1: Set Up Azure Virtual Machine

### 1.1 Create Virtual Machine

- Navigate to the Azure Portal and create a new Virtual Machine in the desired Resource Group.

### 1.2 Configure VM Basics

- **Instance Details:**
  - Security type: Trusted launch virtual machines
  - Image: Ubuntu Server 22.04 LTS - x64 Gen2
  - VM architecture: x64
  - Size: B1ms

### 1.3 Administration Account

- Authentication type: SSH public key
- SSH Key Type: RSA SSH Format

### 1.4 Inbound Port Rules

- Public inbound ports: Allow selected ports
- Select inbound ports: HTTP, HTTPS, SSH

### 1.5 Disks Configuration

- **OS Disk:**
  - OS disk size: image default (30GiB)
  - OS disk type: Standard SSD (locally-redundant storage)
  - Delete with VM: true
  - Key management: Platform-managed key

### 1.6 Networking

- **Network Interface:**
  - Create a virtual network with a public IP
  - NIC network security group: Basic
  - Public Inbounds: As described in Inbound Port Rules
  - Load balancing options: none

## Step 2: Prepare the Virtual Machine

### 2.1 Update and Upgrade Packages

```bash
sudo apt update && sudo apt upgrade -y
```

### 2.2 Generate SSH Key
```bash
ssh-keygen
cat /home/azureuser/.ssh/id_rsa.pub
```
- Add the generated SSH key to your remote repository for clone access.

### 2.3 Clone Repository
```bash
git clone https://github.com/leandro-hoenen/ChatGPT-Workshop
cd ChatGPT-Workshop
```
### 2.4 Configure Enviroment Variables
Create a .env file and populate it with your environment variables:
```bash
touch .env
# Add the following environment variables to the .env file
```
```bash
RAILS_ENV=production
POSTGRES_HOST=db
POSTGRES_DB=llm-workshop_production
POSTGRES_USER=llmworkshop
POSTGRES_PASSWORD=<your password>
RAILS_MASTER_KEY=<your rails master key located under /config/master.key>
STUDENT_KEY=‚<your student key>
LECTURER_KEY=<your lecturer key>
```

## Step 3: Deploy Docker in the VM
Follow the Docker installation instructions for Ubuntu: [Docker Engine Installation on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

## Step 4: Deploy Nginx
Install Nginx and configure it as a reverse proxy to forward requests to your application.
```bash
sudo apt install nginx -y
```

### 4.1 Nginx Configuration
- Create and edit the Nginx configuration file for your application:
sudo nano /etc/nginx/sites-available/chatgptworkshop
```bash
sudo nano /etc/nginx/sites-available/chatgptworkshop
```
- Add the following server block:
```bash
server {
    listen 80;
    
    server_name _;

    location / {
            proxy_pass http://localhost:3000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
    }
}
```

- Enable the new site configuration:
```bash
sudo ln -s /etc/nginx/sites-available/chatgptworkshop /etc/nginx/sites-enabled/
sudo service nginx restart
```

## Step 5: Docker Compose and Deployment
- Navigate to your application directory and start your application using Docker Compose:
```bash
cd ChatGPT-Workshop
docker compose up -d
```

## Step 6: Expose Running Container via Nginx
Remove the default Nginx site and restart Nginx to apply changes:
```bash
sudo rm /etc/nginx/sites-enabled/default
sudo service nginx restart
```

Congratulations! Your ChatGPT Workshop application should now be successfully deployed and accessible through your VM's public IP address.