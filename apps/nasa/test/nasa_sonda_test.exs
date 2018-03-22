defmodule Sonda.Test do
  use ExUnit.Case
  doctest Nasa.Sonda

  test "Deve retornar a mesma struct quando não há instruções" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 1}, direcao: :s, instrucoes: []}
    assert ^sonda = Nasa.Sonda.mover(sonda)
  end

  test "Deve mover a sonda uma posição ao norte" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :n, instrucoes: [:m]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 3}, direcao: :n, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mover a sonda uma posição ao sul" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :s, instrucoes: [:m]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 1}, direcao: :s, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mover a sonda uma posição ao oeste" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :w, instrucoes: [:m]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 0, y: 2}, direcao: :w, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mover a sonda uma posição ao leste" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :e, instrucoes: [:m]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 2, y: 2}, direcao: :e, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do norte para o leste" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :n, instrucoes: [:r]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :e, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do leste para o sul" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :e, instrucoes: [:r]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :s, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do sul para o oeste" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :s, instrucoes: [:r]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :w, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do oeste para o norte" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :w, instrucoes: [:r]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :n, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do norte para o oeste" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :n, instrucoes: [:l]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :w, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do oeste para o sul" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :w, instrucoes: [:l]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :s, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do sul para o leste" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :s, instrucoes: [:l]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :e, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve mudar a direção da sonda do leste para o norte" do
    sonda = %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :e, instrucoes: [:l]}

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :n, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve retornar a Sonda em {1 3 N}" do
    sonda = %Nasa.Sonda{
      coordenadas: %Nasa.Ponto{x: 1, y: 2},
      direcao: :n,
      instrucoes: [:l, :m, :l, :m, :l, :m, :l, :m, :m]
    }

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 3}, direcao: :n, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve retornar a Sonda em {5 1 E}" do
    sonda = %Nasa.Sonda{
      coordenadas: %Nasa.Ponto{x: 3, y: 3},
      direcao: :e,
      instrucoes: [:m, :m, :r, :m, :m, :r, :m, :r, :r, :m]
    }

    assert %Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 5, y: 1}, direcao: :e, instrucoes: []} =
             Nasa.Sonda.mover(sonda)
  end

  test "Deve printar uma Sonda" do
    assert "5 10 N" ==
             Printable.print(%Nasa.Sonda{direcao: :n, coordenadas: %Nasa.Ponto{x: 5, y: 10}})
  end
end
