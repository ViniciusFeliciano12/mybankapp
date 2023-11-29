FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

COPY BankAPI.csproj .
RUN dotnet restore
RUN dotnet ef migrations add InitialCreate
RUN dotnet ef database update

COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 3000

ENTRYPOINT ["dotnet", "BankAPI.dll"]