
1. Instalar o Docker na máquina
2. Baixar o arquivo e acessar o arquivo
3. Criar o arquivo ENV para adicionar as variáveis de ambienete
4. Construir a imagem Docker `docker build -t nome-da-imagem:versão .`
5. Executar a imagem `docker run --rm -it -v $(pwd):blu-crawler nome-da-imagem:versão`

Busca
- Não há a necessidade de colocar o nome completo
- Retorna todos os nomes que começam com o nome passado
- Se não escrever nada, retornará todos os fornecedores.

- Usar os operadores `and` para **'E'** ou `or` para **'OU'**.
- Caso deseje buscar pela categoria e/ou região, o operador `operator` é obrigaório, caso contrário, retornará todos os Fornecedores.