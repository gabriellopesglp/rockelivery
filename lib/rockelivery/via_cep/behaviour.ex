defmodule Rockelivery.ViaCep.Behaviour do
  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Response

  @callback get_cep_info(String.t()) :: {:ok, Response.t()} | {:error, Error.t()}
end
