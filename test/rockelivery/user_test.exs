defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/1" do
    test "when all parems are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Gabriel"}, valid?: true} = response
    end

    test "when there is some error, returns an invalid changeset" do
      params = build(:user_params, %{"age" => 15, "password" => "123"})

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "when all parems are valid, returns a valid changeset" do
      params = build(:user_params)

      update_params = %{name: "Capirvara"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Capirvara"}, valid?: true} = response
    end

    test "when there is some error, returns an invalid changeset" do
      params =
        build(:user_params, %{
          "cpf" => "123456789",
          "cep" => "12345",
          "email" => "gaberaemail.com"
        })

      response = User.changeset(params)

      expected_response = %{
        cpf: ["should be 11 character(s)"],
        cep: ["should be 8 character(s)"],
        email: ["has invalid format"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
