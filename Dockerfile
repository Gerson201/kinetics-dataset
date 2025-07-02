# Usa uma imagem base leve com Ubuntu, que é boa para ferramentas de linha de comando
FROM ubuntu:22.04

# Define variáveis de ambiente para evitar perguntas interativas durante instalações
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza a lista de pacotes e instala as dependências necessárias
# wget: para baixar arquivos da web
# git: para clonar o repositório do kinetics-dataset
# python3-pip: para instalar yt-dlp
# ffmpeg: muitas vezes usado por yt-dlp para processar vídeos
# procps: fornece 'ps', útil para alguns scripts ou depuração
RUN apt-get update && \
    apt-get install -y wget git python3-pip ffmpeg procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instala yt-dlp usando pip (melhor alternativa ao youtube-dl)
# --no-cache-dir para economizar espaço
# --break-system-packages para evitar aviso de venv no Ubuntu 22.04+
RUN pip3 install --no-cache-dir --break-system-packages yt-dlp

# Copia o script de download para dentro do contêiner
COPY download_script.sh /usr/local/bin/download_script.sh

# Dá permissão de execução ao script
RUN chmod +x /usr/local/bin/download_script.sh

# Define o ponto de entrada do contêiner
# Isso significa que, ao executar o contêiner, ele executará este script.
ENTRYPOINT ["/usr/local/bin/download_script.sh"]