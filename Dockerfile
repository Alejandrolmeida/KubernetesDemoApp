# # The `FROM` instruction specifies the base image. You are
# # extending the `microsoft/aspnetcore` image.

# FROM microsoft/aspnetcore

# # Next, this Dockerfile creates a directory for your application
# WORKDIR /app
# COPY src/ContainerDemoApp/bin/Release/PublishOutput .

# # The final instruction copies the site you published earlier into the container.
# ENTRYPOINT ["dotnet", "ContainerDemoApp.dll"]

FROM microsoft/aspnetcore-build AS builder
 WORKDIR /source

  # caches restore result by copying csproj file separately
 COPY . .
 RUN dotnet restore

 # copies the rest of your code
 #COPY \src\. .
 RUN dotnet publish --output /app/ --configuration Release

 # Stage 2
FROM microsoft/aspnetcore
 WORKDIR /app
 COPY --from=builder /app .
 ENTRYPOINT ["dotnet", "ContainerDemoApp.dll"]