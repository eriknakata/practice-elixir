**Pré-requisitos**
- Elixir 1.6.4

**Validações implementadas**

- Não é possivel adicionar duas sondas na mesma coordenada (x, y);
- Instruções diferentes de L, M, R são consideradas inválidas;
- Não é possível adicionar uma Sonda fora da área da malha ou em uma direção diferente de N, S, W, E;
- Uma Sonda pode se mover para fora da malha, porém será notificado na saída de dados;
- A malha deve respeitar a condição: x > 0 && y > 0

**Como executar o projeto**

Navegar até a subpasta do projeto apps/text_client e executa o comando:

```
mix do deps.get, start
```
