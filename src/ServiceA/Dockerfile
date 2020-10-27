#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM registry.cn-shanghai.aliyuncs.com/yangww/dotnetruntime:v1.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM registry.cn-shanghai.aliyuncs.com/yangww/dotnetsdk:v1.0 AS build
WORKDIR /src
#COPY ["src/ServiceA/ServiceA.csproj", "src/ServiceA/"]
COPY ["ServiceA/", "src/ServiceA/"]
COPY ["src/Service.Common/Service.Common.csproj", "src/Service.Common/"]
RUN dotnet restore "src/ServiceA/ServiceA.csproj"
COPY . .
WORKDIR "/src/src/ServiceA"
RUN dotnet build "ServiceA.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ServiceA.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ServiceA.dll"]