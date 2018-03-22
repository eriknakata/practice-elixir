# Xerpa

**Pré-requisitos**
- Elixir 1.6.4

**Validações implementadas**

- Não é possivel adicionar duas sondas na mesma coordenada (x, y);
- Instruções diferentes de L, M, R são consideradas inválidas;
- Não é possível adicionar uma Sonda fora da área da malha ou em uma direção diferente de N, S, W, E;
- Uma Sonda pode se mover para fora da malha, porém será notificado na saida de dados;

**Como executar o projeto**

Navegar até a subpasta do projeto apps/text_client e executa os comando:

```
mix do deps.get, start
```
