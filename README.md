<div align="center">
  <h1>Loader PPPwn</h1>
  <p>PPPwn é um exploit de execução remota de código do kernel para PlayStation 4 até a Firmware 11.00. Baseado na POC compartilhada pelo usuário TheOfficialFloW, foi desenvolvido um script para automação de execução.</p>
</div>

# 📒 Índice
* [Descrição](#descrição)
* [Requisitos Funcionais](#requisitos)
  * [Features](#features)
* [Tecnologias](#tecnologias)
* [Instalação](#instalação)
* [Licença](#licença)

# 📃 <span id="descrição">Descrição</span>
PPPwn é um exploit de execução remota de código do kernel para PlayStation 4 até a Firmware 11.00. Esta é uma exploração de prova de conceito para [**CVE-2006-4304**](https://hackerone.com/reports/2177925) que foi relatada de forma responsável à PlayStation. Baseado na POC compartilhada pelo usuário [**TheOfficialFloW**](https://github.com/TheOfficialFloW/PPPwn), foi desenvolvido um script para automação de execução.

# 📌 <span id="requisitos">Requisitos Funcionais</span>
- [x] Suporte a multi versões do GoldHen<br>
- [x] Multi stages 1 e 2 para as firmware's: 7.50, 7.51, 7.55, 8.00, 8.01, 8.03, 8.50, 8.52, 9.00, 9.03, 9.04, 9.50, 9.51, 9.60, 10.00, 10.01, 10.50, 10.70, 1071, 11.00<br>
- [x] Possibilidade inserir os valores para a identificação da interface de rede e firmware<br>
- [x] Repetição da execução do script com intervalo definidos pelo usuário<br>
- [x] Persistência dos parâmetros para a execução do script e sua reutilização<br>

## Features
- [x] Parâmetros padrões<br>
- [x] Execução automática caso não havendo interação do usuário<br>

# 💻 <span id="tecnologias">Tecnologias</span>
- **Distribuição baseada em Debian**
- **Python3**
- **scapy**

# 🚀 <span id="instalação">Instalação</span>
- **ATENÇÃO** o `loader` e o `script` são executados a nível de usuário `root`. Portanto é de total responsabilidade do usuário a execução, não nos responsabilizamos por problemas causados pelo os mesmos.

No dispositivo a ser executado o script:
```bash
  # Clone este repositório:
  $ git clone https://github.com/CleilsonAndrade/loader-pppwn.git
  $ cd ./loader-pppwn
```

- Abra a pasta `GoldHEN`, copie a última versão do `goldhen.bin` correspondente a firmware do seu PS4 no diretório raiz de um dispositivo de armazenamento USB no formato `exFAT`;

```bash
  # Instalar as dependências:
  $ sudo pip install -r requirements.txt

   # Executar:
  $ ./script_pppwn_loader.sh
```

No seu PS4:
- No seu PS4 insira o dispositivo de armazenamento USB contendo o `goldhen.bin`;

- Conecte o PS4 ao dispositivo a ser executado o script usando um cabo de rede lan;

- Entre em `Configurações` -> `Rede` do PS4;

- Selecione `Configurar conexão à Internet` e escolha `Usar um cabo (LAN)`;

- Em `Como deseja configurar a conexão à internet` selecione `Personalizar`;

- Em `Configurações de endereço IP` selecione `PPPoE`;

- Digite qualquer coisa para `ID de usuário PPPoE` e `Senha PPPoE`;

- Escolha `Automático` para `Configurações de DNS` e `Configurações de MTU`;

- Escolha `Não usar` para `Servidor proxy`;

- Escolha `Testar conexão à Internet`.

Observações:
- Se o loader falhar ou o PS4 travar, você pode pular a `Configurar conexão à Internet` e simplesmente clicar em `Testar conexão com a Internet`. 

- Se o loader funcionar, você deverá ver `Não é possível conectar-se à rede.` seguido por `PPPwned` em seu PS4 por meio de notificação e a ativação da `GoldHEN` seguidamente. 

# 📝 <span id="licença">Licença</span>
Esse projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

<p align="center">
  Feito com 💜 by CleilsonAndrade
</p>