# snowflake-dataops

This repo includes a dataOps approach to deploy changes into Snowflake using AWS Developer tools.

Services used: 
1. CodeCommit
2. CodeBuild
3. CodePipeline
4. Cloudformation
5. Flyway?

To implement your dataOps with Snowflake using this codebase please follow below steps:

1.  Create a snowflake service user and store the credentials in secrets manager
2. Open aws_seed.yaml file and update line 404 with the arn to your secret manager password
```
  - <The arn to the secrets manager that holds Snowflake Password>
```
3. Create other Snowflake resources including: SnowflakeMigrationDatabaseName, SnowflakeWarehouse and SnowflakeRole
4. Update both parameter files pipeline/aws_seed-cli-parameters.json and aws_seed.json 
5. Deploy




This repo uses Inception Pipeline for creating CI/CD pattern using AWS developer tools. Please refer to below links for more details:

1. [Seeds of Inception - Seeding your Account with an Inception Pipeline](https://mechanicalrock.github.io/2018/03/01/inception-pipelines-pt1.html)
2. [Seeds of Inception - Sprouting some website goodness](https://mechanicalrock.github.io/2018/04/01/inception-pipelines-pt2.html)
3. [Seeds of Inception - Sharing the website goodness](https://mechanicalrock.github.io/2018/05/18/inception-pipelines-pt3.html)
4. [Seeds of Inception - Seeding a forest](https://mechanicalrock.github.io/2018/06/25/inception-pipelines-pt4.html)
5. [Seeds of Inception - Access all accounts](https://mechanicalrock.github.io/2018/07/31/inception-pipelines-pt5.html)
6. [Seeds of Inception - Initiating the Seeding](https://mechanicalrock.github.io//2018/08/27/inception-pipelines-pt6)
7. [Seeds of Inception - Global CloudTrail](https://mechanicalrock.github.io/2019/07/09/inception-pipelines-pt7.html)
