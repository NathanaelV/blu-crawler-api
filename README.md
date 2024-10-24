
# Blu-Crawler-API
Essa aplicação tem o objetivo de coletar todos os fornecedores do site https://fornecedores.blu.com.br/ e disponibilizá-los via API.

## Pré-requisitos
Para executar esse projeto local, será necessário instalar o [Docker](https://docs.docker.com/engine/install/) e o Docker compose.<br>
    *A versão utilizada nesse projeto foi a **27.3.1**.*

## Clone do projeto

Clone o projeto para sua máquina

```bash
git clone git@github.com:NathanaelV/blu-crawler-api.git
```

Acesse o diretório da aplicação

```bash
cd blu-crawler-api
```

## Configurações iniciais
Com o Docker compose já instalado, execute o seguinte comando parar construir a imagem

```bash
docker compose build
```

Execute as configurações iniciais

```bash
docker compose run --rm web-api bin/setup
```

Após finalizar as configurações, execute o seguinte comando para executar a aplicação.

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

---

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

---

### Fornecedores

Buscar todos os fornecedores cadastrados

```
GET '/api/v1/suppliers'
```

**Status 200**

```json
[
    {
        "id": 1,
        "name": "Caloi",
        "category": {
            "id": 1,
            "name": "Bicicletas"
        },
        "states": [
            {
                "id": 1,
                "name": "Todo o Brasil"
            }
        ]
    },
    {
        "id": 2,
        "name": "GRUPO PDL - POSITIVO",
        "category": {
            "id": 1,
            "name": "Bicicletas"
        },
        "states": [
            {
                "id": 2,
                "name": "AC"
            },
            {
                "id": 3,
                "name": "AM"
            },
            {
                "id": 4,
                "name": "TO"
            }
        ]
    }
]
```

Caso não tenha fornecedores cadastradas, retornará um Array vazio.

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

Buscar um fornecedor pelo ID

```
GET '/api/v1/suppliers/:id'
```

**Status 200**

```json
{
    "id": 1,
    "name": "Caloi",
    "category": {
        "id": 1,
        "name": "Bicicletas"
    },
    "states": [
        {
            "id": 1,
            "name": "AM"
        },
        {
            "id": 2,
            "name": "TO"
        }
    ]
}
```

Caso busque por um fornecedor que não exites

**Status 404**

```json
[
    {
        "message":"404 - Elemento não encontrado"
    }
]
```

**Status 500**

```json
[
    {
        "message":"500 - Problema do lado do servidor"
    }
]
```

---

## Pesquisa por API

### Pesquisar pelo nome de Fornecedor

```
GET '/api/v1/suppliers/search?name=nome_desejado'
```

*No lugar de `nome_desejado` substitua pelo nome do fornecedor. Não use espaços, use o underscore no lugar dos espaços*


```json
// Retorno para get '/api/v1/suppliers/search?name=cal'

[
    {
        "id": 1,
        "name": "Caloi",
        "category": {
            "id": 1,
            "name": "Bicicletas"
        },
        "states": [
            {
                "id": 1,
                "name": "Todo o Brasil"
            }
        ]
    },
    {
        "id": 2,
        "name": "Caloi Brasil",
        "category": {
            "id": 1,
            "name": "Bicicletas"
        },
        "states": [
            {
                "id": 1,
                "name": "Todo o Brasil"
            }
        ]
    }
]
```

Caso não encontre fornecedores com o nome passado, retornará um Array vazio.

```json
[ ]
```

---

### Pesquisar por Região e/ou Categoria

Podemos filtrar um fornecedor de uma determinada categoria ou que esteja em uma região específica, porém é ncessáiro passar o ID da região ou da categoria.

```
GET '/api/v1/suppliers/search?category_id=:id&state_id=:id'
```

Substitua o `:id` pelo o ID que deseja

```json
// Retorno para get '/api/v1/suppliers/search?category_id=1&state_id=2'

[
    {
        "id": 1,
        "name": "Caloi",
        "category": {
            "id": 1,
            "name": "Bicicletas"
        },
        "states": [
            {
                "id": 1,
                "name": "Todo o Brasil"
            }
        ]
    },
    {
        "id": 3,
        "name": "Braslar",
        "category": {
            "id": 2,
            "name": "Eletrônicos"
        },
        "states": [
            {
                "id": 2,
                "name": "BA"
            }
        ]
    },
    {
        "id": 4,
        "name": "Groove",
        "category": {
            "id": 1,
            "name": "Bicicletas"
        },
        "states": [
            {
                "id": 2,
                "name": "BA"
            }
        ]
    }
]
```

Também é possǘiel filtrar só passando um dos IDs

```
GET '/api/v1/suppliers/search?category_id=:id'
```

ou

```
GET '/api/v1/suppliers/search?state_id=:id'
```

#### AND

Para filtrar por uma região específica e uma categoria, adicione `operator=and`

```
GET '/api/v1/suppliers/search?category_id=:id&state_id=:id&operator=and'
```

Substitua o `:id` pelo o ID que deseja

```json
// Retorno para get '/api/v1/suppliers/search?category_id=1&state_id=2&operator=and'

[
    {
        "id": 4,
        "name": "Groove",
        "category": {
            "id": 1,
            "name": "Bicicletas"
        },
        "states": [
            {
                "id": 2,
                "name": "BA"
            }
        ]
    }
]
```

Caso não encontre fornecedores, retornará um Array vazio.

```json
[ ]
```
