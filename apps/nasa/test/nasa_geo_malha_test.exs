defmodule Malha.Test do
  use ExUnit.Case
  doctest Nasa.Malha

  test "Não deve adicionar duas sondas na mesma coordenada mesmo em diferentes direções" do
    {:ok, malha} = Nasa.Malha.new(5, 5)

    {:ok, malha} =
      malha
      |> Nasa.Malha.adicionar_sonda(%Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 1}, direcao: :s})

    assert {:error, :duplicated} =
             malha
             |> Nasa.Malha.adicionar_sonda(%Nasa.Sonda{
               coordenadas: %Nasa.Ponto{x: 1, y: 1},
               direcao: :n
             })

    assert length(malha.sondas) == 1
  end

  test "Deve permitir adicionar duas sondas quando posições são diferentes" do
    {:ok, malha} = Nasa.Malha.new(5, 5)

    {:ok, malha} =
      malha
      |> Nasa.Malha.adicionar_sonda(%Nasa.Sonda{coordenadas: %Nasa.Ponto{x: 1, y: 2}, direcao: :s})

    assert {:ok, malha} =
             malha
             |> Nasa.Malha.adicionar_sonda(%Nasa.Sonda{
               coordenadas: %Nasa.Ponto{x: 1, y: 1},
               direcao: :n,
               instrucoes: [:l, :m]
             })

    assert length(malha.sondas) == 2
  end

  test "Não deve permitir adicionar uma sonda quando direção é inválida" do
    {:ok, malha} = Nasa.Malha.new(5, 5)

    assert {:error, :unknown_direction} =
             malha
             |> Nasa.Malha.adicionar_sonda(%Nasa.Sonda{
               coordenadas: %Nasa.Ponto{x: 1, y: 1},
               direcao: :a
             })

    assert length(malha.sondas) == 0
  end

  test "Não deve permitir adicionar uma sonda quando alguma instrução é desconhecida" do
    {:ok, malha} = Nasa.Malha.new(5, 5)

    assert {:error, :unknown_instruction} =
             malha
             |> Nasa.Malha.adicionar_sonda(%Nasa.Sonda{
               coordenadas: %Nasa.Ponto{x: 1, y: 1},
               direcao: :s,
               instrucoes: [:l, :m, :z]
             })

    assert length(malha.sondas) == 0
  end

  test "Não deve permitir adicionar uma sonda fora da area" do
    {:ok, malha} = Nasa.Malha.new(5, 5)

    assert {:error, :out_of_range} =
             malha
             |> Nasa.Malha.adicionar_sonda(%Nasa.Sonda{
               coordenadas: %Nasa.Ponto{x: 6, y: 6},
               direcao: :s,
               instrucoes: [:l, :m]
             })

    assert length(malha.sondas) == 0
  end
end
