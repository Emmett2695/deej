@ECHO OFF

IF "%GOPATH%"=="" GOTO NOGO

ECHO Building deej (development)...

REM shove git commit, version tag into env
for /f "delims=" %%a in ('git rev-list -1 --abbrev-commit HEAD') do @set GIT_COMMIT=%%a
for /f "delims=" %%a in ('git describe --tags --always') do @set VERSION_TAG=%%a
set BUILD_TYPE=dev
ECHO Embedding build-time parameters:
ECHO - gitCommit %GIT_COMMIT%
ECHO - versionTag %VERSION_TAG%
ECHO - buildType %BUILD_TYPE%

go build -o deej-dev.exe -ldflags "-X main.gitCommit=%GIT_COMMIT% -X main.versionTag=%VERSION_TAG% -X main.buildType=%BUILD_TYPE%" .\cmd
ECHO Done.
GOTO DONE

:NOGO
ECHO GOPATH environment variable not set
GOTO DONE

:DONE
