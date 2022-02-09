defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Delete

  describe "call/1" do
    test "when there is a user with the given ID, deletes the user" do
      id = "04f0fbd4-d231-40ea-8170-3a8cc20586bf"
      insert(:user)

      response = Delete.call(id)

      assert {
               :ok,
               %User{
                 age: 23,
                 email: "gabera@email.com",
                 id: "04f0fbd4-d231-40ea-8170-3a8cc20586bf",
                 address: "Rua teste, 110",
                 cep: "12345678",
                 cpf: "12345678900",
                 name: "Gabriel",
                 password: nil,
                 password_hash: nil
               }
             } = response
    end

    test "when there is no user with ID, returns the error" do
      id = "b04f0d8a-6977-4b40-b6cf-40bd0a64f764"
      insert(:user)

      response = Delete.call(id)

      assert {:error, %Error{status: :not_found, result: "User not found"}} = response
    end
  end
end
