
SET CurrentDir=%~dp0
cd /D "%CurrentDir%"
webhook.exe -port 8000 -verbose -hooks hooks.yaml >>webhook.log 2>&1

