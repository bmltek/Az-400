# Implement an Instrumentation Strategy

## Configure and integrate with monitoring tools such as Azure Monitor and Application Insights for a Devops Environment

### Azure Monitor Service

Azure Monitor is a service in azure that help you to monitor your resources.

- create some resources as part of your subscription.
- You can scope out matrics for various resources that are part of the subscription
- search (monitor) -> metrics -> rg -> vmss (app-set) -> apply -> select( metric): percentage CPU `You can save the graph to your dashboard`
- monitor -> Activity log -> `You will see the different administrator activities that has been perform on your resources` _. you can change the `TimeSpan`. You will see all the activity/operations that has been conducted within the time-span on your resources.
  - This is useful because if something fails, you can go to azure monitor service/Activity log to see the message as to wy the error occur. This help you to debbug the error accordingly. The JSON tab will give you the information about the event itself. As it will give you the insight as per why the error occur. This is helpful to debug why a deployment/action fails.

#### Azure Monitor - Setting up alerts based on Static threshold

This is useful if you want to notify users/team members when metric goes beyond a threshold.

monitor -> alerts -> Create (alert rule) -> select resources/scope: <vm-name> -> done -> condition -> select a signal (metrics/activity log/log(custom log search) `Custom log search take you to log analytics workspace`/Resource Health(vm health)): `metrics`, percentage CPU -> threshold (Static/dynamic) : static, operator `greater than`, Aggregation type `Average`, Threshold value `70`, Frequency of Evaluation: `every 1 minutes` This means that the alert rule is going to check every one mins if the average cpu percentage is greater than 70 percent, Aggregation granularity (period) `5 minutes` It means that azure monitor service should take the average aggregate date over the last 5 mins to make decision on whether the CPU percentage is greater than 70 percent or not. It depends on the aggregation type. -> actions (select action groups/create action group): `create action group` (This comes as a seperate resource in your subscription) : (Action Group name: GroupA -> notification type: email/SMS message/Push/voice -> put your email/team email -> ok -> Name `EmailAdministrator` -> create `This action group will be assign to your alert`) -> give alert rule name -> alert rule description -> review and create

#### Azure Monitor - Setting up alerts based on dynamic threshold

The azure monitor uses machine learning to check the historical behavior of metrics.
Based on the historical data, it can then identify patterns and anomalies that could indicate possible issues.

`Azure-Monitor Sensitivity`- When defining dynamic threshold, we can choose the sensitivity.

`High` - Here the alert rule will be triggered even for the smallest deviation.

`medium` - here you have more balanced thresholds and fewer alerts will be generated.

`Low` - Here alerts will only triggered on large deviations.

monitor -> alerts -> create -> alert rule -> select a resource -> select a signal -> metrics -> Cpu percentage -> threshold (dynamic) operator `greater or less than` Aggregation type `Average` threshold Sensitivity `Medium` ( we are not puting static value`)

The monitoring services will look at the metrics of CPU overtime for your vmss and it will then determine what is the normal CPU percentage for your VMSS overtime. If there is a deviation over a period of time, it will go ahead and trigger alert. The azure monitor determines the idea cpu percentage over time and make decision based on the vmss cpu percentage metrics history. The azure monitor use ML to determine what should be the idea threshold value for vmss Cpu percentage overtime for this resource.

## Log analytics workspace

This is a center storage for logs. This helps to send all logs to a centralized location.
`Kusto query language` is used to query log analytics workspace.
With the help of log analytics workspace, you can collect data from your resources and query them as needed. 

- Create log analytics workspace

**log analytics workspace**-> virtual machines -> select vm -> connect (click) It will apply an extension of log analytics agent that will be install on the vm to collect the metrics for log analytics and send accordingly
**log analytics workspace** -> Agents management
-> Data collection Rules -> create -> Rule Name `<rule-name>`, platform type `windows`, next -> Add resources  -> choose <vm-name> -> apply -> next  -> Add Data source -> Data source Type (performance counters/ windows even logs) : windows event logs `event logs`: Application `(Information)` Security `(Audit success, Audit failure)` System `(Error, Warning)` -> next -> Destination -> add <log-analytics-workspace-name> -> Add data source -> Review and create

Go to <SQL-Database-Name> -> diagnostics settings -> add diagnostic setting -> choose (allLogs) -> Diagnostic setting name <give-seting-name> -> destination details <log-analytics-workspace-name>

Go to log analytics workspace -> logs -> filter based on Resource type -> select SQL database then select AzureDiagnostics -> query to run below and run it

```kQL
AzureDiagnostics
Event
```

## Service Map Solution

`Discovery:` This solution helps to discover application components on windows and linux based systems.

`Information:` You can see information such as connections between servers, latency for connections etc.
Before you can use this solution, your machines that are going to be part of service map needs to be connected to log analytics workspace.
The machines also need to have `dependency agent` installed on them. 

### How to use Service Map solution

- vm/vmss must be connected to log analytics workspace
- install dependency agent on vm/vmss using the template below
- create ServiceMap in azure Log analytics Workspace
- SolutionMap -> summary ( our machines is now reporting to services map after waiting for some minutes) -> click on the vm. You will see all the different ports connecting to the vm, you will see all the clients that are trying to connect to the vm from port 3389 and it will give you information on processes running on your vm machine.

```azure ARM Template
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "vmName": {
      "type": "string",
      "metadata": {
        "description": "The name of existing Azure VM. Supported Windows Server versions:  2008 R2 and above (x64)."
      }
    }
  },
  "variables": {
    "vmExtensionsApiVersion": "2017-03-30"
  },
  "resources": [
    {
      "type": "Microsoft.Compute/virtualMachines/extensions",
      "name": "[concat(parameters('vmName'),'/DAExtension')]",
      "apiVersion": "[variables('vmExtensionsApiVersion')]",
      "location": "[resourceGroup().location]",
      "dependsOn": [],
      "properties": {
          "publisher": "Microsoft.Azure.Monitoring.DependencyAgent",
          "type": "DependencyAgentWindows",
          "typeHandlerVersion": "9.10",
          "autoUpgradeMinorVersion": true,
          "settings": {
                "enableAMA": "true"
		    }
      }
    }
  ],
    "outputs": {
    }
}
```

We now have the below dependencies install in our vm

- DAExtension - This is the dependency agent extension
- MicrosoftMonitoringAgent
- MicrosoftMonitorWindows

## Virtual Machine Scale sets Notifications

vmss <vmss-name> -> scaling -> configure -> custom autoscale  -> create new condition to autoscale based on network traffic `Network in total (average)` -> notify (You can send notification when autoscale is enabled) `send email as regards when scaling occurs` -> add diagnostics settings -> logs (Autoscale Scale actions) -> destination Details <log-analytics-workspace-name> -> save

After some times, you will get notification that the capacity of your instance is changing.

## Configure and integrate with monitoring tools such as Application Insights

This provides the feature of **application performance management and monitoring of live web applications.**

Its help to detect performance issues or any other issues.
Its support pyton, Node.js, Java, .NET.
This works for applications hosted on azures, on-premises environments or other cloud platforms.
It has integration with visual studio IDE.
You can see how users interact with your application.
The telemetry data sent to Application Insights has very little impact on the overall performance of your application.

### How it works

You can install a small instrumentation package (SDK) for your applications. or use the Application Insight Agent.
You can instrument web applications, background components and javaScript in web pages.

- Create Azure web App attached with Application Insights (we have two resources created)
- Go to the application insight created -> Application insights (preview)
- Go to visual studio -> right click on your project that you want to deploy to azure web app -> configure Application insights (choose) -> choose `Azure Applocation insights` -> next -> choose the resource -> next -> next -> finish -> publish app to web app that is integrated with the application insight
- Go to the application insight (created) -> live metrics (As you engage with the app, you will start seeing life metrics of the application)
- Application insight -> availability `you can do basic test against your application i.e to see if the app is reachable for different location` -> add standard test -> test name <test-name> URL <azure-webapp-url> click `parse dependent requests` -> create
  - if you want to check all dependent request i.e if the webapp has images or javaScripts and you want to see that all are check to confirm its loads as expected.
  - Test frequency is 5 minutes by default.
  - You can test your application for various locations.
  - You are making a GET request and expecting a 200 response.
We have two types of availability test:

- Classic test
- Standard test

### Users, sessions and Events

We get live telementry data from Application Insights

**Users** - Here you can see how many people have used your application and its features.

**Session** - You can see sessions of user activity. This includes certain pages and features of the applications.

**Events** - This gives a view of how often certain pages and features have been used in the application.

**Funnels** - Here you can have multiple stages like a pipeline. and then you can see how users are progressing through your application as an entire process.

**Cohorts** - This is a set of users, sessions, events or operations that have something in common. It helps to analyze a particular set of users or events.

**Impact:** Here you can see how the low times and other aspects of your application impact the conversion rate of the application itself.

**Retention:** Here you can analyze how many users return back to your application.

**User Flows:** This helps in answering questions such as:

- what do users click on a page within the application?
- Where are the places within the application the users churn out the most in the site?
- Are there places in the application where the users repeat the same action over and over again?

Application insights -> performance 
`You will see all the operations that have been performed on your web application. Each get request that have been made, you will see the average duration and the count as well.`

### Smart Detection - Failure Anomalies

[Smart detection in Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/proactive-diagnostics)

Smart detection feature when it comes to failures.
Here you can be alerted in real time if your web application experiences any sort of `abnormal rise in terms of rate of failed requests`.

So instead of you trying to track this, this can be done automatically with the help of the smart detection feature when it comes onto Application Insights.

If we go onto Application Insights resource and you scroll down,there is something known as the `smart detection settings`, and all of this is already enabled for you.

All of these rules are already enabled.
And how do you get notified?

If I go onto the `monitor service` -> alert -> action groups

There will automatically be an action group known as `Application Insights Smart Detection` that gets created because you've created that `Application Insights resource`.
You can click on the edit button. Here there are already some notifications in place, but then you can always go ahead and add your own notifications and your own actions onto the action group.

**Notes**
In our case, when we created the Application Insights resource it was created along with the Azure Web app.
Now, the default way of Application Insights storing its data is via a Log Analytics workspace.
So, in the background you'll have a Log Analytics workspace that stores all of the data
that is being recorded by Application Insights.
There you will see that it is being linked onto a default workspace.

In fact, you can separately create an `Application Insights resource` and probably link it onto an existing `Log Analytics workspace`.

## Azure Container Instances probe

[Configure readiness probes](https://learn.microsoft.com/en-us/azure/container-instances/container-instances-readiness-probe)

Having commands in place to check if a container is ready.

[Configure liveness probes](https://learn.microsoft.com/en-us/azure/container-instances/container-instances-liveness-probe)

## Azure Devops notification

Azure devops -> user settings -> Notification -> alot of notifications are already in place as you can only view them. You can create a new subscription
Azure devops -> user settings -> Notification -> new subscription -> Build (a build complete) -> next -> `add emails that get notify when a build get complete`

## IT Service Management integration

[IT Service Management integration](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/itsmc-overview)

When it comes on to Azure, you have the alerts that can be defined for various metrics

that are being recorded in the Azure monitoring service.

But your company might be using an external tool when it comes onto, let's say, `incident management`.

So if there is any sort of incident that actually occurs in your production-based environment.

So let's say that an alert gets generated while the use of the CPU going beyond a particular threshold for your Azure virtual machine.

Now, you also want to ensure as a company that an `incident`, you know, a problem gets recorded in the `service management solution` that they are using.

So they could be using `ServiceNow` as a service management solution.

At that point in time they might want to have an `integration` between `Azure Monitor` and the `service management solution`.
They can make use of `IT Service Management Connector` so they can connect their `service management solution` onto `Azure Monitor`.
So whenever an `alert gets triggered` within the `Azure monitoring service`, it could create an incident within their `service management solution`.
