FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
ARG PROJETO=TrilhaApiDesafio.csproj
COPY . .
RUN dotnet restore $PROJETO
RUN dotnet publish $PROJETO -c Release -o /app/publish

# Mais leve p runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .
#http
EXPOSE 5181 
ENV ASPNETCORE_URLS=http://+:5181
ENTRYPOINT ["dotnet", "TrilhaApiDesafio.dll"]