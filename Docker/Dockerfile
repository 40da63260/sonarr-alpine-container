FROM mcr.microsoft.com/dotnet/sdk as builder
WORKDIR /repo
COPY ./src/NzbDrone.Console/ .
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
# because of changes in docker and systemd we need to not build in parallel at the moment
# see https://success.docker.com/article/how-to-reserve-resource-temporarily-unavailable-errors-due-to-tasksmax-setting
RUN dotnet build Sonarr.console --disable-parallel --framework x86 --output="/sonarr" --self-contained --runtime linux-x64 "-p:DebugSymbols=false;DebugType=none"

FROM alpine:3
COPY --from=builder /sonarr /sonarr
ENTRYPOINT /sonarr
