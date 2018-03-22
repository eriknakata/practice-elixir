defmodule Nasa.Sonda do
  alias Nasa.Ponto

  defstruct coordenadas: %Ponto{}, direcao: :n, instrucoes: []

  @doc ~S"""
  Retornar a Sonda com as coordenadas atualizadas de acordo com as instruções
  """
  def mover(%Nasa.Sonda{instrucoes: []} = sonda), do: sonda

  def mover(%Nasa.Sonda{instrucoes: [:m | tail], direcao: :n} = sonda) do
    mover(%{
      sonda
      | instrucoes: tail,
        coordenadas: %Ponto{x: sonda.coordenadas.x, y: sonda.coordenadas.y + 1}
    })
  end

  def mover(%Nasa.Sonda{instrucoes: [:m | tail], direcao: :s} = sonda) do
    mover(%{
      sonda
      | instrucoes: tail,
        coordenadas: %Ponto{x: sonda.coordenadas.x, y: sonda.coordenadas.y - 1}
    })
  end

  def mover(%Nasa.Sonda{instrucoes: [:m | tail], direcao: :w} = sonda) do
    mover(%{
      sonda
      | instrucoes: tail,
        coordenadas: %Ponto{x: sonda.coordenadas.x - 1, y: sonda.coordenadas.y}
    })
  end

  def mover(%Nasa.Sonda{instrucoes: [:m | tail], direcao: :e} = sonda) do
    mover(%{
      sonda
      | instrucoes: tail,
        coordenadas: %Ponto{x: sonda.coordenadas.x + 1, y: sonda.coordenadas.y}
    })
  end

  def mover(%Nasa.Sonda{instrucoes: [:r | tail], direcao: :n} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :e})
  end

  def mover(%Nasa.Sonda{instrucoes: [:r | tail], direcao: :e} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :s})
  end

  def mover(%Nasa.Sonda{instrucoes: [:r | tail], direcao: :s} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :w})
  end

  def mover(%Nasa.Sonda{instrucoes: [:r | tail], direcao: :w} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :n})
  end

  def mover(%Nasa.Sonda{instrucoes: [:l | tail], direcao: :n} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :w})
  end

  def mover(%Nasa.Sonda{instrucoes: [:l | tail], direcao: :w} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :s})
  end

  def mover(%Nasa.Sonda{instrucoes: [:l | tail], direcao: :s} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :e})
  end

  def mover(%Nasa.Sonda{instrucoes: [:l | tail], direcao: :e} = sonda) do
    mover(%{sonda | instrucoes: tail, direcao: :n})
  end
end

defimpl Printable, for: Nasa.Sonda do
  def print(sonda),
    do:
      "#{sonda.coordenadas.x} #{sonda.coordenadas.y} #{
        sonda.direcao |> Atom.to_string() |> String.upcase()
      }"
end
