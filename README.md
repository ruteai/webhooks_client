# Cliente local para webhooks de integração com **Rute.ai**

Com o cliente de webhooks da **Rute.ai**, você pode conectar os serviços da **Rute.ai** com o seu aplicativo médico, onde quer que esteja em execução. Ele substitui o gerenciamento de VPNs, abertura de portas do firewall, aquisição de IP permanente para o seu link de acesso à internet e certificados de segurança válidos.

Sua finalidade é permitir que um software de gestão de saúde, mesmo estando instalado em um computador local, sem um IP público acessível pela internet, possa ser integrado com a **Rute.ai**.

## Como instalar ?

### Crie um diretório para a aplicação

```
cd /
mkdir Rute
cd Rute
mkdir webhook_client
```

### Download de programas externos

Faça o download dos seguintes aplicativos para o diretório criado anteriormente:

* [Inlets para Windows](https://github.com/inlets/inlets/releases/download/3.0.0/inlets.exe)
* [NSSM - Configurador de aplicativos como serviços](https://nssm.cc/ci/nssm-2.24-101-g897c7ad.zip)
* [Webhooks - servidor de entrada de webhooks para executar comandos shell](https://github.com/adnanh/webhook/releases/download/2.8.0/webhook-windows-amd64.tar.gz)
* [Caddy - Servidor HTTP para teste da conexão](https://caddyserver.com/api/download?os=windows&arch=amd64&idempotency=17322521938054)

## Teste suas credenciais

Você recebeu da nossa empresa um endereço de conexão e uma chave de autenticação. Faça uma validação deles executando o seguinte comando estando dentro do diretório criado anteriormente:

```
inlets.exe client --url wss://ENDERECODACONEXAO --upstream=http://localhost:80 --token=CHAVE
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

Deixe o programa `inlets` rodando na atual janela de comando e **abra uma nova janela**. Na nova janela de comando vá para o diretório onde os programas executáveis estão e crie um arquivo de texto simples (use o notepad) chamado **`caddyfile`** (sem extensão mesmo) e coloque nele o seguinte conteúdo:

```
:2015

respond "Funcionou!!! Acessando um site no meu computador local usando uma URL pública."
```

Depois de salvar o arquivo execute o seguinte comando:

```
caddy_windows_amd64.exe run --config=caddyfile
```

Em seguida abra o seu navegador e acesse a URL https://ENDERECODACONEXAO e confirme se o texto correto é exibido.

