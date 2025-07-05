Updated 10 Hands-On Assignments for AWS IAM


### Create a new IAM user with programmatic access. Assign permissions to access a specific S3 bucket.

Create a user and store credentials to a local file

        aws iam create-user --user-name raj --output table > credentials.txt
         
Create access keys for user to grant programatic access

        aws iam create-access-key --user-name raj --outbput table >> credentials.txt

Assign Raj permission to acess a specific bucket i.e attach policy to acess specific bucket.

     aws iam attach-user-policy --user-name raj --policy-arn <policy_arn>arn:aws:iam::750552037338:policy/S3_Emage_Tech_Acess

Validate this was done

          aws iam list-attached-user-policies --username raj # outputs list of polices attached to raj

To view policy content (json output)

          aws iam get-policy-version --policy-arn arn:aws:iam::750552037338:policy/S3_Emage_Tech_Acess --version-id v2


### Implement IAM Groups
    
Create an IAM group for developers, attach a policy allowing full access to EC2, and add users to the group.

     Create a group for delopers

          aws iam create-group --group-name developers

     Add Users to group

          aws iam add-user-to-group --group-name dev --user-name raj
     
     Attach S:3fullAccess policy to group

          > get policy arn from console
          
          aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name dev

> Validate
          aws iam list-attached-group-policies --group-name dev

          
### Configure a password policy requiring specific length, complexity, and expiration settings for IAM users.

        aws iam update-account-password-policy \
            --minimum-password-length 14 \
                --require-uppercase-characters \
                --require-lowercase-characters \
                --require-numbers \
                --require-symbols \
                --max-password-age 90 \
                --password-reuse-prevention 5 \
                --allow-users-to-change-password   # For users with console Access

4. Create a Custom IAM Policy
     Write a custom policy in JSON format that allows access to DynamoDB but denies delete operations.

     Create a custom .json policy
     