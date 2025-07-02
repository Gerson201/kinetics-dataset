#!/bin/bash

# Define a versão do Kinetics que você quer baixar (ex: k400, k600, k700_2020)
# Você pode passar isso como uma variável de ambiente se quiser flexibilidade.
KINETICS_VERSION=${KINETICS_VERSION:-k400} # Padrão para k400 se não especificado

echo "Baixando o dataset Kinetics-${KINETICS_VERSION}..."

# Clonar o repositório kinetics-dataset
git clone https://github.com/cvdfoundation/kinetics-dataset.git /tmp/kinetics-dataset

# Entrar no diretório do dataset
cd /tmp/kinetics-dataset

# Baixar o dataset usando o script apropriado
# Usamos `bash` explicitamente para garantir que o script seja executado corretamente.
if [ "$KINETICS_VERSION" = "k400" ]; then
    bash k400_downloader.sh
elif [ "$KINETICS_VERSION" = "k600" ]; then
    bash k600_downloader.sh
elif [ "$KINETICS_VERSION" = "k700_2020" ]; then
    bash k700_2020_downloader.sh
else
    echo "Versão do Kinetics não suportada neste script: $KINETICS_VERSION"
    exit 1
fi

echo "Download concluído (ou o script do Kinetics finalizou)."

# O dataset baixado estará na pasta `videos` dentro de /tmp/kinetics-dataset
# ou em uma estrutura semelhante, dependendo do script do Kinetics.
# Quando você montar o volume, ele estará diretamente mapeado para sua máquina host.

# Mantém o contêiner ativo por um tempo para inspeção, se necessário
# sleep 3600 # Opcional: mantém o contêiner rodando por 1 hora para depuração