defmodule TextClient do
  alias Nasa.{Malha, Sonda, Ponto}

  def start, do: coletar_coordenadas()

  defp coletar_coordenadas do
    inputs = IO.gets("1 - Digite as coordenadas\n")
    inputs |> String.split() |> converter_dados_malha |> validar_coordenadas
  end

  defp converte_coordenadas(inputs) do
    inputs
    |> Enum.flat_map(fn input ->
      case Integer.parse(input) do
        {int, _} -> [int]
        :error -> []
      end
    end)
  end

  defp converter_dados_malha(inputs) do
    with [x, y] <- inputs,
         [x, y] <- converte_coordenadas([x, y]),
         do: Nasa.Malha.new(x, y)
  else
    {:ok, malha} -> {:ok, malha}
    _ -> {:error}
  end

  defp validar_coordenadas({:ok, malha}) do
    coletar_dados_sonda(malha)
  end

  defp validar_coordenadas(_) do
    IO.puts("Coordenadas invalidas")
    coletar_coordenadas()
  end

  defp coletar_dados_sonda(%Nasa.Malha{} = malha) do
    coordenadas = IO.gets("2 - Digite as coordenadas da sonda e a direcao\nEx: 1 5 N\n")
    instrucoes = IO.gets("2 - Digite as instrucoes da Sonda\nEx: LMLMLMLMM\n")

    coordenadas = coordenadas |> String.split()

    instrucoes =
      instrucoes
      |> String.replace("\n", "")
      |> String.downcase()
      |> String.codepoints()
      |> Enum.map(fn char -> String.to_atom(char) end)

    converter_dados_sonda(coordenadas, instrucoes, malha) |> validar_dados_sonda
  end

  defp converter_dados_sonda(coordenadas, instrucoes, %Malha{} = malha) do
    with [x, y, direcao] <- coordenadas,
         [x, y] <- converte_coordenadas([x, y]),
         do:
           Nasa.Malha.adicionar_sonda(malha, %Sonda{
             coordenadas: %Ponto{x: x, y: y},
             direcao: direcao |> String.downcase() |> String.to_atom(),
             instrucoes: instrucoes
           })
  else
    {:ok, malha} -> {:ok, malha}
    _ -> {:error, malha}
  end

  defp validar_dados_sonda({:ok, %Malha{sondas: sondas} = malha}) when length(sondas) == 1 do
    IO.puts("Ainda precisamos dos dados da segunda sonda.\n")
    coletar_dados_sonda(malha)
  end

  defp validar_dados_sonda({:ok, %Malha{sondas: sondas} = malha}) when length(sondas) == 2 do
    malha = %{malha | sondas: Enum.map(malha.sondas, fn sonda -> Nasa.Sonda.mover(sonda) end)}
    malha |> Printable.print() |> IO.puts()
    exit(:normal)
  end

  defp validar_dados_sonda({:error, %Malha{} = malha}) do
    IO.puts("Dados da sonda invalidos")
    coletar_dados_sonda(malha)
  end
end
