# OWASP Scanner within Pipeline

## *Open Web Application Security Project*

`Add OWASPTONUnit3.xslt file to the app you want to build in azure repo. Just the way you will add templates or terraform config t your project.`
The OWASPToNUnit.xslt need to be commit to the azure repo/github.

We want to use Zap scanner to run Azure web app. This OWASP Zap tool is available as a docker image. we can create a container using the azure container instance.

The application running in that container instance can then run a scan against the application running on the azure web app.

The result of the container instance needs to be persistence i.e must be available in the file share in the azure storage account.

[Azure DevOps Pipelines: Leveraging OWASP ZAP in the Release Pipeline](https://devblogs.microsoft.com/premier-developer/azure-devops-pipelines-leveraging-owasp-zap-in-the-release-pipeline/)

[Use the compose extension](https://learn.microsoft.com/en-us/azure/devops/boards/integrations/boards-teams?view=azure-devops)

[Explore the world of cyber security](https://owasp.org/)

In fact, you would've heard of OWASP top 10.

These are the `top 10 critical security risks on to web applications`.

You will get details on the site when it comes on to these top 10 application security risks.

Now, there is a tool known as the `Zap scanner` that you can use as part of your pipeline.

What this scanner can do is it can actually go on to your website and look at all of the security risks based on what is defined by OWASP themselves.

