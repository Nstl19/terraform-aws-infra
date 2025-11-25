# Terraform AWS Infrastructure Project

---

## Project Structure

<img width="750" height="690" alt="aws-terraform-infra-structure" src="https://github.com/user-attachments/assets/2a54385e-ee04-47c3-80d7-68ee2bd2a4c0" />


## Deployed

### **1. VPC + Networking**
- Custom VPC (10.0.0.0/16)  
- Two public subnets across different AZs  
- Internet Gateway  
- Public route table + associations  

### **2. EC2 Compute Layer**
- EC2 instance in a public subnet  
- Nginx auto-installed using `user_data.sh`  
- SSH access enabled using an existing key pair  
- IAM role attached to allow S3 access

### **3. S3 Storage**
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
