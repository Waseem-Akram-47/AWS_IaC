# AWS_IaC


# AWS Cloud Infrastructure and Kubernetes Deployment

This project demonstrates how to use Infrastructure as Code (IaC) with Terraform and Kubernetes manifests to deploy a cloud architecture on AWS. The architecture includes a VPC, subnets, EC2 instances, RDS instances, and Kubernetes deployments.

## Project Structure

. ├── terraform │ ├── main.tf │ ├── variables.tf │ ├── outputs.tf │ └── provider.tf └── k8s ├── deployment.yaml ├── service.yaml ├── configmap.yaml ├── secret.yaml └── pvc.yaml

## Terraform Configuration

The Terraform configuration sets up the following AWS resources:

- **VPC and Subnets**: A VPC with CIDR block `192.168.0.0/16` and both public and private subnets.
- **Internet Gateway and NAT Gateway**: An Internet Gateway for public subnets and a NAT Gateway for private subnets to allow outbound internet access.
- **Route Tables**: Route tables for public and private subnets, associating them with the appropriate gateways.
- **EC2 Instances**: An EC2 instance (SSM Host) in the public subnet for SSM Port Forward access.
- **RDS Instances**: RDS MariaDB instances (master and replica) with asynchronous replication.
- **Security Groups**: Security groups to allow necessary traffic, such as port 3306 for MariaDB.

### Files

- `main.tf`: Defines the main resources for the VPC, subnets, gateways, and instances.
- `variables.tf`: Contains variable definitions for the VPC and subnet CIDR blocks.
- `outputs.tf`: Outputs the IDs of the created resources.
- `provider.tf`: Configures the AWS provider.

### Usage

1. **Initialize Terraform**:
    ```sh
    cd terraform
    terraform init
    ```

2. **Apply the Terraform configuration**:
    ```sh
    terraform apply
    ```

## Kubernetes Manifests

The Kubernetes manifests deploy the following resources:

- **Deployment**: Defines a deployment for the application with environment variables sourced from a Kubernetes Secret.
- **Service**: Creates a LoadBalancer service to expose the application.
- **ConfigMap**: ConfigMap for application configuration.
- **Secret**: Secret for sensitive data like database passwords.
- **Persistent Volume Claim**: PVC for persistent storage needs.

### Files

- `deployment.yaml`: Defines the deployment for the application.
- `service.yaml`: Creates a LoadBalancer service to expose the application.
- `configmap.yaml`: ConfigMap for application configuration.
- `secret.yaml`: Secret for sensitive data.
- `pvc.yaml`: Persistent Volume Claim for storage.

### Usage

1. **Apply the Kubernetes manifests**:
    ```sh
    kubectl apply -f k8s/
    ```

## Detailed Explanation

### Terraform Configuration

1. **VPC and Subnets**:
   - The VPC is created with a CIDR block of `192.168.0.0/16`.
   - Public and private subnets are defined with specific CIDR blocks to segregate the network.

2. **Internet Gateway and NAT Gateway**:
   - An Internet Gateway is attached to the VPC to allow internet access for public subnets.
   - A NAT Gateway is created in one of the public subnets to provide internet access for instances in private subnets.

3. **Route Tables**:
   - Public route tables are associated with public subnets and route traffic to the Internet Gateway.
   - Private route tables are associated with private subnets and route traffic to the NAT Gateway.

4. **EC2 Instances**:
   - An EC2 instance is deployed in the public subnet to act as an SSM Host, allowing secure access to other instances via SSM Port Forwarding.

5. **RDS Instances**:
   - RDS MariaDB instances are configured with one master and one replica for asynchronous replication, ensuring high availability and data redundancy.

6. **Security Groups**:
   - Security groups are created to allow traffic on necessary ports, such as port 3306 for MariaDB, ensuring secure access to the database instances.

### Kubernetes Manifests

1. **Deployment**:
   - The deployment defines the application pods, specifying the container image, ports, environment variables, and volume mounts.
   - Environment variables are sourced from a Kubernetes Secret to securely manage sensitive data.

2. **Service**:
   - A LoadBalancer service is created to expose the application to external traffic, allowing users to access the application via a public IP.

3. **ConfigMap**:
   - A ConfigMap is used to manage application configuration, allowing dynamic updates without redeploying the application.

4. **Secret**:
   - A Secret is used to store sensitive data, such as database passwords, ensuring secure management of credentials.

5. **Persistent Volume Claim**:
   - A PVC is created to provide persistent storage for the application, ensuring data is retained across pod restarts.

## Conclusion

This project demonstrates how to use Terraform for AWS infrastructure provisioning and Kubernetes for application deployment. The provided configurations and manifests can be customized to fit specific requirements. By following the instructions and explanations provided, you can deploy a robust and scalable cloud architecture on AWS.

## License

This project is licensed under the MIT License.
