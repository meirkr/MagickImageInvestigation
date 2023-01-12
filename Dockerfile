FROM mcr.microsoft.com/dotnet/sdk:7.0 as builder

WORKDIR /src

# copy sln and all the project files (recursively)
COPY MagickImageInvestigation.csproj ./

# restore solution
RUN dotnet restore -r alpine-x64 MagickImageInvestigation.csproj

# copy all the rest
COPY . .

# Build runtime image
RUN dotnet publish --no-restore -c Release -r alpine-x64 --sc false -o out "MagickImageInvestigation.csproj"

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine as final

WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY --from=builder /src/out .
ENTRYPOINT ["dotnet", "MagickImageInvestigation.dll"]
