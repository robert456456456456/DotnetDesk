FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env1
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env1 /app/out .
ENTRYPOINT ["dotnet", "src.dll"]