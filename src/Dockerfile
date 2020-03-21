# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8

LABEL maintainer="sanderson@eye-catcher.com"

LABEL maintainer="sanderson@eye-catcher.com"
SHELL ["powershell.exe", "-Command"]

COPY ./scripts /scripts
RUN /scripts/install.ps1 

CMD ["powershell", "-f", "c:/scripts/run.ps1"]
