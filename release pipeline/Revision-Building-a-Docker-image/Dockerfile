FROM mcr.microsoft.com/dotnet/aspnet:6.0 As build
WORKDIR /source
COPY  *.csproj ./
RUN dotnet restore

COPY . .
RUN donet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY  --from=build /source/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "sqlapp.dll"]

# deploy with using building the project before publish
# FROM mcr.microsoft.com/dotnet/aspnet:6.0
# WORKDIR /app
# COPY  . .
# EXPOSE 80
# ENTRYPOINT ["dotnet", "sqlapp.dll"]