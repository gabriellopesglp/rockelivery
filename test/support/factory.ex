defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => "Rua teste, 110",
      "age" => 23,
      "cep" => "13355000",
      "cpf" => "12345678900",
      "email" => "gabera@email.com",
      "password" => "123456",
      "name" => "Gabriel"
    }
  end

  def user_changeset_params_factory do
    %{
      "address" => "Rua teste, 110",
      "age" => 23,
      "cep" => "13355000",
      "cpf" => "12345678900",
      "email" => "gabera@email.com",
      "password" => "123456",
      "name" => "Gabriel",
      "city" => "Elias Fausto",
      "uf" => "SP"
    }
  end

  def user_factory do
    %User{
      address: "Rua teste, 110",
      age: 23,
      cep: "13355000",
      city: "Elias Fausto",
      uf: "SP",
      cpf: "12345678900",
      email: "gabera@email.com",
      password: "123456",
      name: "Gabriel",
      id: "04f0fbd4-d231-40ea-8170-3a8cc20586bf"
    }
  end
end
