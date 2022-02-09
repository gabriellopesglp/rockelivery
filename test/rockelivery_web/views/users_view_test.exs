defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %User{
               address: "Rua teste, 110",
               age: 23,
               cep: "12345678",
               cpf: "12345678900",
               email: "gabera@email.com",
               id: "04f0fbd4-d231-40ea-8170-3a8cc20586bf",
               inserted_at: nil,
               name: "Gabriel",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end

  test "renders user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %Rockelivery.User{
               address: "Rua teste, 110",
               age: 23,
               cep: "12345678",
               cpf: "12345678900",
               email: "gabera@email.com",
               id: "04f0fbd4-d231-40ea-8170-3a8cc20586bf",
               inserted_at: nil,
               name: "Gabriel",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
