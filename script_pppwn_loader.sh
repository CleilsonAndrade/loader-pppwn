#!/bin/bash

# Obtém o diretório onde o script está localizado
SCRIPT_DIR="$(dirname "$0")"

# Arquivo de configuração no diretório do script
CONFIG_FILE="$SCRIPT_DIR/.pppwn_config"

# Lista de opções de firmware
firmware_options=('750' '751' '755' '800' '801' '803' '850' '852' '900' '903' '904' '950' '951' '960' '1000' '1001' '1050' '1070' '1071' '1100')

echo "[+] Loader for PPPwn by Cleilson Andrade"

# Verifica se o arquivo de configuração existe
if [ -f "$CONFIG_FILE" ]; then
    # Carrega as configurações do arquivo
    source "$CONFIG_FILE"
    # Pergunta ao usuário se deseja continuar com os valores existentes
    read -t 5 -p $'Valores padrão já existentes no arquivo de configuração.\nDeseja continuar com estes valores? (S/N): ' continue_existing || continue_existing=""
    if [[ $continue_existing == "n" || $continue_existing == "N" ]]; then
        # Solicita ao usuário os novos valores das variáveis
        read -p $'Informe a interface de rede do seu dispositivo (padrão: eth0):  ' user_interface

        # Exibe as opções de firmware para seleção
        echo "Escolha a firmware do seu PS4 (padrão: 1100): "
        select fw_option in "${firmware_options[@]}"; do
            # Define o firmware selecionado ou mantém o padrão se nenhuma opção for selecionada
            FW="${fw_option:-$FW}"
            break
        done

        # Solicita ao usuário o valor de sleep
        read -p $'Informe o tempo de espera (em segundos) entre as execuções (padrão: 90): ' user_sleep

        # Armazena os novos valores fornecidos pelo usuário no arquivo de configuração
        echo "INTERFACE=${user_interface:-$INTERFACE}" > "$CONFIG_FILE"
        echo "FW=$FW" >> "$CONFIG_FILE"
        echo "SLEEP=${user_sleep:90}" >> "$CONFIG_FILE"

        # Carrega novamente as configurações do arquivo
        source "$CONFIG_FILE"
    fi
else
    # Define os valores padrão se o arquivo de configuração não existir
    INTERFACE="eth0"
    FW="1100"
    SLEEP="90"

    # Pergunta ao usuário se deseja continuar com os valores padrão
    read -t 5 -p $'Valores padrão não estão configurados.\nDeseja continuar com os valores padrão? (S/N): ' continue_default
    if [[ $continue_default == "n" || $continue_default == "N" ]]; then
        # Solicita ao usuário os novos valores das variáveis
        read -p $'Informe a interface de rede do seu dispositivo (padrão: eth0):  ' user_interface

        # Exibe as opções de firmware para seleção
        echo "Escolha a firmware do seu PS4 (padrão: 1100): "
        select fw_option in "${firmware_options[@]}"; do
            # Define o firmware selecionado ou mantém o padrão se nenhuma opção for selecionada
            FW="${fw_option:-$FW}"
            break
        done

        # Solicita ao usuário o valor de sleep
        read -p $'Informe o tempo de espera (em segundos) entre as execuções (padrão: 90): ' user_sleep

        # Armazena os novos valores fornecidos pelo usuário no arquivo de configuração
        echo "INTERFACE=${user_interface:-$INTERFACE}" > "$CONFIG_FILE"
        echo "FW=$FW" >> "$CONFIG_FILE"
        echo "SLEEP=${user_sleep:-$SLEEP}" >> "$CONFIG_FILE"

        # Carrega novamente as configurações do arquivo
        source "$CONFIG_FILE"
    else
        # Cria um novo arquivo de configuração com os valores padrão
        echo "INTERFACE=$INTERFACE" > "$CONFIG_FILE"
        echo "FW=$FW" >> "$CONFIG_FILE"
        echo "SLEEP=$SLEEP" >> "$CONFIG_FILE"
    fi
fi

# Exibe os valores das variáveis
echo ""
echo "Interface de rede do dispositivo: $INTERFACE"
echo "Firmware do PS4: $FW"
echo "Tempo de espera entre execuções: $SLEEP segundos"
echo ""

# Função para tratar a interrupção (Ctrl+C)
handle_interrupt() {
    echo ""
    echo "Execução interrompida pelo usuário."
    exit 0
}

# Define o trap para o sinal SIGINT
trap handle_interrupt SIGINT

# Inicia o loop que executa o script original com os valores fornecidos pelo usuário
while true; do
    sudo bash -c "python3 pppwn.py --interface=$INTERFACE --fw=$FW --stage1=stages/FW-$FW/stage1/stage1.bin --stage2=stages/FW-$FW/stage2/stage2.bin" & 
    sleep $SLEEP
    echo ""
    sudo pkill -f "python3 pppwn.py"
    python_exit_code=$?
    if [[ $python_exit_code -ne 0 ]]; then
        handle_interrupt
    fi
done
