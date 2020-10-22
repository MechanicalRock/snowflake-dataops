# snowflake-dataops

This repo includes a dataOps approach to deploy changes into Snowflake using AWS Developer tools.

To implement your dataOps with Snowflake using this codebase please follow below steps:
1. Create an encrypted RSA public and private key. Type below two commands in your command line
```
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.p8
Enter a password
openssl rsa -in rsa_key.p8 -pubout -out rsa_key.pub
Enter your previous pass
```

2. Create a snowflake service user and assign RSA public key to it
```
create user pipeline_sys_user;
alter user pipeline_sys_user set rsa_public_key_2='MIIBIjANBgkqh...';
```

3. Store the password in aws secrets manager as plain text and name it "snowflake/pipeline_sys_user/secret"


4. Open aws_seed.yaml file and update line number 404 with the arn to your secret manager password
```
  - <The arn to the secrets manager that holds Snowflake Password>
```
5. Create other Snowflake resources including: SnowflakeMigrationDatabaseName, SnowflakeWarehouse and SnowflakeRole
```
Create database pipeline_db_migration_plan;

Create role pipeline_role;
Grant role pipeline_role to user pipeline_sys_user;
grant all on database pipeline_db_migration_plan to role pipeline_role;
CREATE WAREHOUSE pipeline_warehouse;
GRANT USAGE ON WAREHOUSE pipeline_warehouse TO ROLE pipeline_role;

<!-- Ideally you only wanna grant permissions that your pipeline needs. Granting SYSADMIN is not encouraged  -->
grant role SYSADMIN to role pipeline_role;

```
6. Update both parameter files pipeline/aws_seed-cli-parameters.json and aws_seed.json 

```
 "SnowflakeUsername": "pipeline_sys_user",
 "SnowflakeMigrationDatabaseName": "pipeline_db_migration_plan",
 "SnowflakeWarehouse": "pipeline_warehouse",
 "SnowflakeRole": "pipeline_role",
```

```
  {
    "ParameterKey": "SnowflakeUsername",
    "ParameterValue": "pipeline_sys_user"
  },
  {
    "ParameterKey": "SnowflakeWarehouse",
    "ParameterValue": "pipeline_warehouse"
  },
  {
    "ParameterKey": "SnowflakeMigrationDatabaseName",
    "ParameterValue": "pipeline_db_migration_plan"
  },
  {
    "ParameterKey": "SnowflakeRole",
    "ParameterValue": "pipeline_role"
  }
```

7. Deploy




Services used: 
1. CodeCommit
2. CodeBuild
3. CodePipeline
4. Cloudformation
5. Flyway?

This repo uses Inception Pipeline for creating CI/CD pattern using AWS developer tools. Please refer to below links for more details:

1. [Seeds of Inception - Seeding your Account with an Inception Pipeline](https://mechanicalrock.github.io/2018/03/01/inception-pipelines-pt1.html)
2. [Seeds of Inception - Sprouting some website goodness](https://mechanicalrock.github.io/2018/04/01/inception-pipelines-pt2.html)
3. [Seeds of Inception - Sharing the website goodness](https://mechanicalrock.github.io/2018/05/18/inception-pipelines-pt3.html)
4. [Seeds of Inception - Seeding a forest](https://mechanicalrock.github.io/2018/06/25/inception-pipelines-pt4.html)
5. [Seeds of Inception - Access all accounts](https://mechanicalrock.github.io/2018/07/31/inception-pipelines-pt5.html)
6. [Seeds of Inception - Initiating the Seeding](https://mechanicalrock.github.io//2018/08/27/inception-pipelines-pt6)
7. [Seeds of Inception - Global CloudTrail](https://mechanicalrock.github.io/2019/07/09/inception-pipelines-pt7.html)
