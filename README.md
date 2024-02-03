# multicloud-repo


## Azure

### Authentication

Authenticate terraform using service principal and client secret on Azure.

#### Run below command to create service principal.
```
az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>

```

#### Add below variables in .auto.tfvars file.
```
ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
ARM_TENANT_ID="<azure_subscription_tenant_id>"
ARM_CLIENT_ID="<service_principal_appid>"
ARM_CLIENT_SECRET="<service_principal_password>"
```
