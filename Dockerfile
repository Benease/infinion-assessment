# Stage 1: Build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy restore dependencies
COPY *.csproj ./
RUN dotnet restore "InfinionDevOps.csproj"

# Copy the rest of the code
COPY . .
RUN dotnet publish "InfinionDevOps.csproj" -c Release -o /app/publish

# Stage 2: Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expose the port the app listens on
EXPOSE 8080

# Run the app
ENTRYPOINT ["dotnet", "InfinionDevOps.dll"]
