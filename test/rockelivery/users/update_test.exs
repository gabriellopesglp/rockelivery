defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Update

  describe "call/1" do
    test "when user exists, updates the user" do
      insert(:user)

      params = %{
        "id" => "04f0fbd4-d231-40ea-8170-3a8cc20586bf",
        "name" => "Capivara"
      }

      response = Update.call(params)

      assert {
               :ok,
               %User{
                 address: "Rua teste, 110",
                 age: 23,
                 cep: "13355000",
                 cpf: "12345678900",
                 email: "gabera@email.com",
                 id: "04f0fbd4-d231-40ea-8170-3a8cc20586bf",
                 name: "Capivara",
                 city: "Elias Fausto",
                 uf: "SP"
               }
             } = response
    end

    test "when user not exists, returns an error" do
      params = %{
        "id" => "04f0fbd4-d231-40ea-8170-3a8cc20586bf",
        "name" => "Capivara"
      }

      response =
        params
        |> Update.call()

      assert {
               :error,
               %Error{
                 result: "User not found",
                 status: :not_found
               }
             } = response
    end
  end
end
