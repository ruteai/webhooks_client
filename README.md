# Cliente local para webhooks de integração com **Rute.ai**

Com o cliente de webhooks da **Rute.ai**, você pode conectar os serviços da **Rute.ai** com o seu aplicativo médico, onde quer que esteja em execução. Ele substitui o gerenciamento de VPNs, abertura de portas do firewall, aquisição de IP permanente para o seu link de acesso à internet e certificados de segurança válidos.

Sua finalidade é permitir que um software de gestão de saúde, mesmo estando instalado em um computador local, sem um IP público acessível pela internet, possa ser integrado com a **Rute.ai**.

## Como instalar ?

### Crie um diretório para os aplictivos da Rute

```
cd /
mkdir Rute
cd Rute
mkdir webhooks_client
```

### Faça o download do progama

Faça o download do programa Rute webhook client para o diretório `webhooks_client` criado anteriormente:

* [Rute - Webhook client](https://github.com/ruteai/webhooks_client/releases/download/v0.1.0/windows.zip)

Quando o download terminar, descompacte o arquivo dentro do diretório `webhooks_client` da Rute e, ao final, você terá um diretório chamadado  `webhooks_client/windows`. Vá para o diretório que corresponda ao seu sistema operacional, no caso:

```
cd webhooks_client/windows
```

## Teste suas credenciais

Você recebeu da nossa empresa um endereço de conexão e uma chave de autenticação. Faça uma validação deles executando o seguinte comando estando dentro do diretório criado anteriormente:

```
inlets.exe client --url wss://ENDERECODACONEXAO --upstream=http://localhost:8000 --token=CHAVE
```

Se tudo estiver correto será exibido algo parecido com isso:

```
Welcome to inlets!

Upgrade to inlets PRO for secure, encrypted tunnels and access to fast cloud
and Kubernetes automation.

Find out more at: https://inlets.dev 

2021/02/12 18:45:39 Starting client - version 3.0.0
2021/02/12 18:45:39 Upstream:  => http://localhost:8000
INFO[2021/02/12 18:45:39] Connecting to proxy                           url="wss://ENDERECODACONEXAO/tunnel"
```

IMPORTANTE: O `inlets` não retorna ao prompt quando é executado com sucesso. Se retornou ao prompt, corrija o erro informado e execute ele novamente.

## Teste o acesso externo ao seu computador

Deixe o programa `inlets` rodando na atual janela de comando e **abra uma nova janela**. Na nova janela de comando vá para o diretório onde os programas estão e execute o seguinte comando:

```
webhook.exe -port 8000 -hooks config/hooks.yaml -verbose
```

Em seguida abra o seu navegador e acesse a URL https://reqbin.com/curl, copie o comando abaixo e coloque no local apropriado e troque E3NDERECODACONEXÃO pelo que você recebeu de nós:

```
curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST https://ENDERECODACONEXAO/hooks/rute-webhook
```

Em seguida, clique no botão `RUN` e verifique se o `Status` é igual a **200 (OK)**. Além disso, o `Content` deve de ter algo simiular a:

```
{
    "status": "OK",
    "dados_recebidos_pelo_webhook": {
        "key1": "value1",
        "key2": "value2"
    }
}
```

Após executar todas as etapas acima com sucesso você está com um tunel seguro pronto para integrar a **Rute.ai** com o seu aplicativo.

## Como fazer a integração do seu aplicativo com o webhook da Rute ?

Existem duas possibilidades de se fazer a integração:

### Usando um servidor HTTP já instalado no seu computador

Se você já tem algum tipo de aplicação desenvolvida em PHP, NodeJS, etc está é a forma mais indicada. Apenas verifique em qual porta TCP o servidor está recebendo os comandos TCP e execute o `inlets.exe` de acordo. Vamos supor que a porta seja `80`, neste caso o comando correto para rodar o tunnel seguro seria:

```
inlets.exe client --url wss://ENDERECODACONEXAO --upstream=http://localhost:80 --token=CHAVE
```

### Recebendo os dados do webhook em um programa executável

Caso você ainda não tenha nenhuma aplicação rodando em um servidor HTTP é possível fazer a integração criando um programa que seja executável por comando de linha, sem interface gráfica, e que receba os dados enviados pela Rute como parametros. No diretório onde estão os executáveis tem um exemplo, que foi o que usamos para testar a conexão. Ele foi escrito em Python e o nome dele é `webhook_client.py`.

Para este tipo de integração você terá de usar o programa `webhook.exe` que nada mais é que um servidor HTTP que recebe osw dados do webhook e executa um programa passando como parametros os dados recebidos da Rute. Supondo que você criou um programa chamado `meu_webhook.exe` basta você editar o arquivo `hooks.yaml` e trocar `execute-command: ./webhook_client.exe` por `execute-command: ./meu_webhook.exe`. **Importante:** essa configuração é se o seu exedcutável está no mesmo diretório que o `webhook.exe`. Se ele estiver em outro diretório também é necessário alterar `command-working-directory` e colocar lá o diretório onde o seu executável está.

A documentação completa do `webhook.exe' está em [Webhook Project](https://github.com/adnanh/webhook)

## Como usar o cliente de webhook da Rute.ai em produção

Tudo o que você testou anteriormente funciona bem em um ambiente de desenvolvimento. No entanto, quando for colocar em produção existe uma exigência básica: Que o tunnel seguro seja inicado automaticamente quando o seu computador é ligado e, se depois o link para a internet cair, o tunel se reconecte automaticamnete.

Para isso é necessário que o cliente do tunel seguro rode no seu computador como um serviço do sistema.

Antes de mais nada encerre a execução de todos os programas dos passoas anteriores. Pode ser dando `CTRL+C` em cada janela ou fechando todas elas.

### Executar o tunel seguro como um serviço do sistema

Abra uma janela de comando dom direitos de administrador. Tem várias formas de fazere isto. Um exemplo está abaixo:

1) Aperte o botão `WIN` no teclado do seu computador
2) Digite `cmd`
3) Clique em `Executar como administrador`
4) Aceite a execução com direitos de administrador

Pronto, agora temos um shell de comando com direitos de administrador e podemos continuar nosso tutorial.

Em seguida, no prompt administrativo aberto vá para o diretório onde está ocloiente do tunnel `inlets.exe' e exedcute o seguinte comando:

```
nssm.exe install rute_webhooks
```

Em seguida será exibida uma tela de configuração com várias abas. Preencha elas conforme instruído a seguir (o que não constar das instruções não precisa ser alterado):

**Application tab:**
```
Path: C:\Rute\webhooks_client\windows\inlets.exe
Startup Directory: C:\Rute\webhooks_client\windows
Arguments: client --url wss://ENDERECODACONEXAO --upstream=http://localhost:PORT --token=TOKEN
```






