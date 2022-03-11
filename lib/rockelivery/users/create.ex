defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.ViaCep.Response

  def call(params) do
    cep = Map.get(params, "cep")

    with {:ok, %User{}} <- User.build(params),
         {:ok, %Response{} = info} <- client().get_cep_info(cep),
         {:ok, params} <- get_location(info, params),
         {:ok, %User{}} = user <- create_user(params) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end

    # case Client.get_cep_info(cep) do
    #   {:ok, %Response{} = info} ->
    #     get_location(info, params)

    #   {:error, _result} = error ->
    #     error
    # end
  end

  defp get_location(info, params) do
    %{localidade: city, uf: uf} = info
    params = Map.merge(%{"city" => city, "uf" => uf}, params)
    {:ok, params}
  end

  defp create_user(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

  defp client do
    :rockelivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end

  # defp client do
  #   Application.fetch_env!(:rockelivery, __MODULE__)[:via_cep_adapter]
  # end
end
