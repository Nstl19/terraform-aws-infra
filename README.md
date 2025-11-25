**Terraform AWS Infrastructure**

---

## Project Structure

<img width="600" height="550" alt="aws-terraform-infra-structure" src="https://github.com/user-attachments/assets/2a54385e-ee04-47c3-80d7-68ee2bd2a4c0" />


## Deployed

### **1. VPC + Networking**
- Custom VPC (10.0.0.0/16)  
- Two public subnets across different AZs  
- Internet Gateway  
- Public route table + associations  
<img width="600" height="700" alt="Screenshot 2025-11-25 104830" src="https://github.com/user-attachments/assets/80f7aeca-1c14-4423-a0e6-2afb56ce9b52" />


### **2. EC2 Compute Layer**
- EC2 instance in a public subnet  
- Nginx auto-installed using `user_data.sh`  
- SSH access enabled using an existing key pair  
- IAM role attached to allow S3 access
<img width="700" height="600" alt="Screenshot 2025-11-25 104640" src="https://github.com/user-attachments/assets/71bd2dee-d0c7-408d-bce9-7928e5862ed0" />

### **3. S3 Storage**
- S3 bucket created automatically  
- EC2 instance gets S3 read/write permissions  
- Bucket name auto-generated from project name
<img width="600" height="700" alt="Screenshot 2025-11-25 104548" src="https://github.com/user-attachments/assets/dd656393-8439-4f8d-8a2d-a481c18ba6e3" />

---

## Tech Used

- **Terraform v1.x**
- **AWS Provider v5.x**
- **AWS Services:** VPC, EC2, S3, IAM
- **Bash (user data script)**  

---

