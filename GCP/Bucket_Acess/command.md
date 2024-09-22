### Creat a new credential for service account
- gcloud iam service-accounts keys create <key_file_name>.json --iam-account=<service_account_email>
- 
### List all previously created files
- gcloud iam service-accounts keys list --iam-account=<service account email>
- 
### Disable a key
- gcloud iam service-accounts keys disable <key_id> --iam-account=<service_account_email>
- 
### Using the generated credeintials file
- GOOGLE_APPLICATION_CREDENTIALS=./config/localaccess.json node test.js