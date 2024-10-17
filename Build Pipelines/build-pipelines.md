# Continuous Integration

**Build pipelines** is part of a process that's known as **continuous integration**.
The term of continuous integration implies onto being able to automatically build and test code every time a team member commits code changes onto version control.
The build tool builds the project and the dependencies into a set of binaries. The binaries can then run on the target machine with the help of the `.NET runtime`. Target machine only understands how to run binary instructions. 

Hence, there should be some way to correlate your application code, into instructions that can be understood by the underlying machine.

That's where the first step is to build your application into a form that can then be taken by something known as, .NET runtime running on a machine that would take the build of your code and then interpret it into binary instructions that can be understood by the underlying machine.

Hence, the first step is to take your code and convert it on to a build that could then be run on a target machine.

That target machine needs to have .NET also installed, then you would only need to have the .NET runtime in place.

Software development kit actually allows you to develop the application and the runtime helps you to run your application.

## Azure Pipelines

With Azure Pipelines, you can authomatically build and test your code commited by the team members.
Azure pipelines can be use for both continuous integration and continuous delivery.
It also support the deployment of the application to multiple environmenta or target.

## How to define Azure Pipelines

1. Yaml Syntax

Yaml -> YAML Ain't Markup Language
This is a human-friendly data serialization language for all programming languages.
It's just a convenient way in which you can actually define your data.
You can structure your data so that it can be understood in a human readable format.

You can define your pipeline in YAML Syntax.
A file called `azure-pipelines.yml` will be created and version controlled along with your code.
When you create your pipeline using the YAML syntax, it'll also be added onto your Git repository within a Azure Repos.
The benefit of this is it allows you to identify now changes within your pipeline that could break the deployment. So you can go back onto previous versions of your pipeline to see what is the working version of your pipeline if a later on change is actually breaking the entire pipeline process.
2. Classic Interface
This gives you a graphical interface. You can define your pipelines with the use of interface and you can run your pipeline accordingly.

## Creating Pipelines

`How to set main baranch as the default branch`

azure repos -> branches -> set main branch as a default branch.
pipelines -> 

## Type of hosting agents

[Build your project](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/dotnet-core?view=azure-devops&tabs=yaml-editor#build-your-project)

## Security and test integration to build pipelines

