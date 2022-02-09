defmodule Rockelivery.Users.Get do
  alias Rockelivery.{Error, Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end

  # Forma com o with
  # def by_id2(id) do
  #   with {:ok, uuid} <- UUID.cast(id),
  #        %User{} = user <- Repo.get(User, uuid) do
  #     {:ok, user}
  #   else
  #     :error -> {:error, %{status: :bad_request, result: "Invalid ID format!"}}
  #     nil -> {:error, %{status: :not_found, result: "User not found!"}}
  #   end
  # end
end
