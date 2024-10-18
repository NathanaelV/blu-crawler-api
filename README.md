
# Blu-Crawler-API
Essa aplicação tem o objetivo de coletar todos os fornecedores do site https://fornecedores.blu.com.br/ e disponibilizá-los via API.

## Pré-requisitos
Para executar esse projeto local, será necessário instalar o [Docker](https://docs.docker.com/engine/install/).<br>
    *A versão utilizada nesse projeto foi a **27.3.1**.*

## Execução do projeto

Clone o projeto para sua máquina

```bash
git clone git@github.com:NathanaelV/blu-crawler-api.git
```

Acesse o diretório da aplicação

```bash
cd blu-crawler-api
```

Com o Docker já instalado, execute o seguinte comando parar construir a imagem

```bash
docker build -t blu-crawler:v1 .
```

Abra a aplicação no terminal Bash

```bash
docker run -it --rm -v $(pwd):/blu-crawler blu-crawler:v1 /bin/bash
```

Caso execute corretamente, verá algo parecido com **`root@81c6a9a5c623:/blu-crawler#`** no seu terminal.<br>
Execute a migration com o seguinte comando:

```bash
rails db:migrate
```

Após executar o comando acima, pode sair do terminal do Docker com **Ctrl + D**. 

Já no seu terminal local, execute o seguinte comando parar construir a imagem e executar a aplicação.

```bash
docker compose up
```

Quando a aplicação estiver prota, terá um código parecido com esse no seu terminal

```bash
blu-crawler  | => Booting Puma
blu-crawler  | => Rails 7.2.1 application starting in development 
blu-crawler  | => Run `bin/rails server --help` for more startup options
blu-crawler  | Puma starting in single mode...
blu-crawler  | * Puma version: 6.4.3 (ruby 3.2.3-p157) ("The Eagle of Durango")
blu-crawler  | *  Min threads: 3
blu-crawler  | *  Max threads: 3
blu-crawler  | *  Environment: development
blu-crawler  | *          PID: 1
blu-crawler  | * Listening on http://0.0.0.0:3000
blu-crawler  | Use Ctrl-C to stop
```
Agora já pode acessar a aplicação pelo http://localhost:3000/.

---


## Funcionalidades

## Crawler

Para coletar as informações, basta clicar no botão *Coletar informações* e aguardar.

## API

### Categorias

Buscar todas as categorias cadastradas:

```
GET '/api/v1/categories'
```

**Status 200**

```json
[
    {
        "id":1,
        "name":"Colchões"
    },
    {
        "id":2,
        "name":"Calçados"
    }
]
```

Caso não tenha categorias cadastradas, retornará um Array vazio.

```json
[ ]
```

**Status 500**

```json
[
    {
        "message":"500 - Problema do lado do servidor"
    }
]
```

### Regiões

Buscar todas as regiões cadastradas.

```
GET '/api/v1/states'
```

**Status 200**

```json
[
    {
        "id":1,
        "name":"BA"
    },
    {
        "id":2,
        "name":"GO"
    }
]
```

Caso não tenha regiões cadastradas, retornará um Array vazio.

```json
[ ]
```

**Status 500**

```json
[
    {
        "message":"500 - Problema do lado do servidor"
    }
]
```

### Fornecedores


Busca
- Não há a necessidade de colocar o nome completo
- Retorna todos os nomes que começam com o nome passado
- Se não escrever nada, retornará todos os fornecedores.

- Usar os operadores `and` para **'E'** ou `or` para **'OU'**.
- Caso deseje buscar pela categoria e/ou região, o operador `operator` é obrigaório, caso contrário, retornará todos os Fornecedores.