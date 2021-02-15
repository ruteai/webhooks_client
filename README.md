# Cliente local para webhooks de integração com **Rute.ai**

Com o cliente de webhooks da **Rute.ai**, você pode conectar os serviços da **Rute.ai** com o seu aplicativo médico, onde quer que esteja em execução. Ele substitui o gerenciamento de VPNs, abertura de portas do firewall, aquisição de IP permanente para o seu link de acesso à internet e certificados de segurança válidos.

Sua finalidade é permitir que um software de gestão de saúde, mesmo estando instalado em um computador local, sem um IP público acessível pela internet, possa ser integrado com a **Rute.ai**.

## Como instalar ?

### Crie um diretório para os aplictivos da Rute

```
cd /
mkdir Rute
cd Rute
```

### Faça o download do progama

Faça o download do Rute webhook client para o diretório criado anteriormente:

* [Rute - Webhook client](https://github.com/ruteai/webhooks_client/archive/main.zip)

Quando o download terminar, descompacte o arquivo dentro do diretório da Rute:

```
unzip -r main.zip
```

Ao final, você terá um diretório chamadado  `webhooks_client`. Vá para o diretório que corresponda ao seu sistema operacional, no caso:

```
cd webhooks_client/windows
```

## Teste suas credenciais

Você recebeu da nossa empresa um endereço de conexão e uma chave de autenticação. Faça uma validação deles executando o seguinte comando estando dentro do diretório criado anteriormente:

```
inlets.exe client --url wss://ENDERECODACONEXAO --upstream=http://localhost:2015 --token=CHAVE
```

Se tudo estiver correto será exibido algo parecido com isso:

```
Welcome to inlets!

Upgrade to inlets PRO for secure, encrypted tunnels and access to fast cloud
and Kubernetes automation.

Find out more at: https://inlets.dev 

2021/02/12 18:45:39 Starting client - version 3.0.0
2021/02/12 18:45:39 Upstream:  => http://localhost:2015
INFO[2021/02/12 18:45:39] Connecting to proxy                           url="wss://ENDERECODACONEXAO/tunnel"
```

IMPORTANTE: O `inlets` não retorna ao prompt quando é executado com sucesso. Se retornou ao prompt, corrija o erro informado e execute ele novamente.

# Teste o acesso externo ao seu computador

Deixe o programa `inlets` rodando na atual janela de comando e **abra uma nova janela**. Na nova janela de comando vá para o diretório onde os programas estão e execute o seguinte comando:

```
caddy_windows_amd64.exe run --config=./config/caddyfile --adapter=caddyfile
```

Em seguida abra o seu navegador e acesse a URL https://ENDERECODACONEXAO e confirme se um texto similar a esse é exibido: `Funcionou!!! Acessando um servidor HTTP no seu computador local usando uma URL externa.`

Se o texto apareceu corretamente o seu cliente de webhook está funcionado corretamente e podemos ir para o passo seguinte.

