SET CurrentDir=%~dp0
cd /D "%CurrentDir%"
inlets client --remote "ws://tunnel.saluscode.com.br:8080" --token "SenhaSuperSecreta2030" --upstream webhook.centrocor.saluscode.com.br=http://127.0.0.1:8000,mysql.centrocor.saluscode.com.br=http://127.0.0.1:5000  >>tunnel.log 2>&1