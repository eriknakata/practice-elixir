defmodule Nasa.Malha do
  @moduledoc """
  Documentation for Nasa.
  """
  alias Nasa.Sonda

  defstruct [:x_a, :y_a, :x_b, :y_b, sondas: []]

  @doc ~S"""
  Parses the given `line` into a command.

  ## Examples

      iex> Nasa.Malha.new(5, 5)
      {:ok, %Nasa.Malha{x_a: 0, y_a: 0, x_b: 5, y_b: 5}}


  Unknown commands or commands with the wrong number of
  arguments return an error:

      iex> Nasa.Malha.new(0, 0)
      {:error, :invalid_input}

      iex> Nasa.Malha.new(5, 0)
      {:error, :invalid_input}

      iex> Nasa.Malha.new(0, 5)
      {:error, :invalid_input}

      iex> Nasa.Malha.new(-5, 5)
      {:error, :invalid_input}

  """

  def new(x_b, y_b) when x_b <= 0 or y_b <= 0 or not is_integer(x_b) or not is_integer(y_b),
    do: {:error, :invalid_input}

  def new(x_b, y_b), do: {:ok, %Nasa.Malha{x_b: x_b, y_b: y_b, x_a: 0, y_a: 0}}

  @doc ~S"""
  Verifica se um determinado `Ponto` faz parte da área de exploração

  ## Examples

      iex> {:ok, malha} = Nasa.Malha.new(5, 5)
      iex> Nasa.Malha.contains?(malha, %Nasa.Ponto{x: 6, y: 5})
      false

      iex> {:ok, malha} = Nasa.Malha.new(5, 5)
      iex> Nasa.Malha.contains?(malha, %Nasa.Ponto{x: 5, y: 5})
      true
  """
  def contains?(%Nasa.Malha{x_b: x_b, y_b: y_b}, %Nasa.Ponto{x: x, y: y}),
    do: x <= x_b and y <= y_b

  @doc ~S"""
  Adiciona uma nova `sonda` na área de exploração
  """
  def adicionar_sonda(%Nasa.Malha{}, %Sonda{direcao: direcao})
      when direcao not in [:n, :s, :w, :e] do
    {:error, :unknown_direction}
  end

  def adicionar_sonda(%Nasa.Malha{} = malha, %Sonda{instrucoes: instrucoes} = sonda) do
    existe = existe?(malha, sonda)
    instrucoes_validas = instrucoes_validas?(instrucoes)
    fora_da_area = not contains?(malha, sonda.coordenadas)
    adicionar(existe, instrucoes_validas, fora_da_area, malha, sonda)
  end

  @doc false
  defp instrucoes_validas?([]), do: true

  @doc false
  defp instrucoes_validas?(instrucoes),
    do: instrucoes |> Enum.all?(fn instrucao -> instrucao in [:m, :l, :r] end)

  @doc false
  defp adicionar(
         false = _nao_existe,
         true = _instrucoes_validas,
         false = _fora_da_area,
         %Nasa.Malha{} = malha,
         %Sonda{} = sonda
       ) do
    malha = %{malha | sondas: malha.sondas ++ [sonda]}
    {:ok, malha}
  end

  @doc false
  defp adicionar(true = _existe, _, _, _, _), do: {:error, :duplicated}

  @doc false
  defp adicionar(_, false = _instrucoes_validas, _, _, _), do: {:error, :unknown_instruction}

  @doc false
  defp adicionar(_, _, true = _fora_da_area, _, _), do: {:error, :out_of_range}

  @doc false
  defp existe?(%Nasa.Malha{sondas: sondas}, %Sonda{coordenadas: coordenadas}) do
    sondas
    |> Enum.any?(fn sonda ->
      sonda.coordenadas.x == coordenadas.x && sonda.coordenadas.y == coordenadas.y
    end)
  end
end

defimpl Printable, for: Nasa.Malha do
  def print(malha),
    do:
      malha.sondas
      |> Enum.map(fn sonda -> print(Nasa.Malha.contains?(malha, sonda.coordenadas), sonda) end)
      |> Enum.join("\n")

  defp print(true = _dentro_da_malha, sonda = %Nasa.Sonda{}) do
    Printable.print(sonda)
  end

  defp print(false, sonda = %Nasa.Sonda{}) do
    "#{Printable.print(sonda)} - Cuidado! A sonda esta se movimentando fora da area de exploracao"
  end
end
