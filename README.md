
1. Instalar o Docker na máquina
2. Baixar o arquivo e acessar o arquivo
3. Criar o arquivo ENV para adicionar as variáveis de ambienete
4. Construir a imagem Docker `docker build -t nome-da-imagem:versão .`
5. Executar a imagem `docker run --rm -it -v $(pwd):blu-crawler nome-da-imagem:versão`
