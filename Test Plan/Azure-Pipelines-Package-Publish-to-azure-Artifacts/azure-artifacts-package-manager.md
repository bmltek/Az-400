# How to use Azure package manager for our organization code

- Go to visual studio and create a project
  - Class library `project` name it as `CoreServicesApp`
  - A developer that is building all the core services that can be use by other devoloper in other projects

## How to setup Artifact in Azure Devops

`A feed is where w publish our packages to and other developers can connect to the feed and consume those packages`
- Click Create Feed
  - Name: CoreServices
  - Visibility: Members of the organization
  - You can include packages from public sources
  - Scope: Project(name) -> create
- You will need to authenticate yourself in other to download packages from this feed

**Feed** is just a mechanism that allows you to store, manage and group packages together.

- Normally the feeds are project-based. Here only the people within the project can access the feed.
- You can also create a public feed. This allows you to share packages within anyone on the internet. This can only be created with public project in Azure devops.

## Requirement for Public Feeds in Azure Artifacts

- They need to be created within public projects
- They cannot have upstream sources
- public users cannot download universal packages

### Upstream Sources

- You can store packages from different sources onto your feed.
- The copy of the package from the `upstream source` will be stored in the feed.
- We can connect our feeds to the public feeds that are available
- By default when we create our feeds, we have option that allow us to include packages from common public sources.
- go to your feed -> settings -> upstream sources `You will see where you can get packages from`
- Public packages install on a project is store on the feed, so that you can use it the next time.

### Feed Views

- This help to share certain packages.
- The default views are `@Local`, `@Prerelease` and `@Release`
- By default all packages are release to the @Local view.

## How to give **Feed** permision

There will be an error in the publish artifact to azure artifact feed if you dont do the below.

- feed -> feed settings -> Permissions -> Add users/groups -> select `Project Collection Build service (organization name)` -> select `contributor` role -> save
- feed -> feed settings -> Permissions -> Add users/groups -> select `<project-name> Build service (<organization-name>)` -> select `contributor` role -> save