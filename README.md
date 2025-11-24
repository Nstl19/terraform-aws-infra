# Terraform AWS Infrastructure Project

This project deploys a complete AWS infrastructure stack using **Terraform**, built to showcase real-world Cloud + DevOps skills.  
Everything is fully automated — no click-ops, no manual setup.

---

## What This Project Deploys

### **1 VPC + Networking**
- Custom VPC (10.0.0.0/16)  
- Two public subnets across different AZs  
- Internet Gateway  
- Public route table + associations  

### **2 EC2 Compute Layer**
- EC2 instance in a public subnet  
- Nginx auto-installed using `user_data.sh`  
- SSH access enabled using an existing key pair  
- IAM role attached to allow S3 access

### **3 S3 Storage**
- S3 bucket created automatically  
- EC2 instance gets S3 read/write permissions  
- Bucket name auto-generated from project name

---

## Tech Used

- **Terraform v1.x**
- **AWS Provider v5.x**
- **AWS Services:** VPC, EC2, S3, IAM
- **Bash (user data script)**  

---
