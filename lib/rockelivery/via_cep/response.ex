defmodule Rockelivery.ViaCep.Response do
  @keys [:localidade, :uf]

  @enforce_keys @keys

  defstruct @keys

  def build_struct(localidade, uf) do
    %__MODULE__{
      localidade: localidade,
      uf: uf
    }
  end
end
