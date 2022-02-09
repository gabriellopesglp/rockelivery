defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Get

  describe "by_id/1" do
    test "when user exists, returns the user" do
      id = "7bd9a991-014b-47e5-a06c-8bd01bee9999"

      insert(:user, id: id)

      response = Get.by_id(id)

      assert {
               :ok,
               %User{
                 address: "Rua teste, 110",
                 age: 23,
                 cep: "12345678",
                 cpf: "12345678900",
                 email: "gabera@email.com",
                 id: "7bd9a991-014b-47e5-a06c-8bd01bee9999",
                 name: "Gabriel"
               }
             } = response
    end

    test "when the user not exits, returns an error" do
      id = "7bd9a991-014b-47e5-a06c-8bd01bee9999"

      response = Get.by_id(id)

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
