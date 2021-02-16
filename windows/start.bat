
SET CurrentDir=%~dp0
cd /D "%CurrentDir%"
START "%CurrentDir%" start_webhook.bat
START "%CurrentDir%" start_tunnel.bat
START "%CurrentDir%" sandman.bat
