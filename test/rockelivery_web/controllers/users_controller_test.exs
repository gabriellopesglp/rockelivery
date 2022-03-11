defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.ViaCep.{ClientMock, Response}

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, %Response{localidade: "Elias Fausto", uf: "SP"}}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua teste, 110",
                 "age" => 23,
                 "cep" => "13355000",
                 "cpf" => "12345678900",
                 "email" => "gabera@email.com",
                 "id" => _id,
                 "name" => "Gabriel",
                 "city" => "Elias Fausto",
                 "uf" => "SP"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = build(:user_params, %{"cpf" => "", "password" => ""})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_resonse = %{
        "message" => %{"cpf" => ["can't be blank"], "password" => ["can't be blank"]}
      }

      assert response == expected_resonse
    end
  end

  describe "delete/2" do
    test "when there is a user with the given ID, deletes the user", %{conn: conn} do
      id = "04f0fbd4-d231-40ea-8170-3a8cc20586bf"
      # Inserir o usuário no banco pela Factory
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when there is no user with ID, returns the error", %{conn: conn} do
      id = "04f0fbd4-d231-40ea-8170-3a8cc20586bf"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:not_found)

      expected_reponse = "{\"message\":\"User not found\"}"

      assert response == expected_reponse
    end
  end

  describe "show/2" do
    test "when there is a user with the given ID, returns the user", %{conn: conn} do
      id = "04f0fbd4-d231-40ea-8170-3a8cc20586bf"
      # Inserir o usuário no banco pela Factory
      insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> response(:ok)

      expected_response =
        "{\"user\":{\"id\":\"04f0fbd4-d231-40ea-8170-3a8cc20586bf\",\"name\":\"Gabriel\",\"email\":\"gabera@email.com\",\"cpf\":\"12345678900\",\"age\":23,\"cep\":\"13355000\",\"address\":\"Rua teste, 110\",\"city\":\"Elias Fausto\",\"uf\":\"SP\"}}"

      assert response == expected_response
    end

    test "when there is no user with ID, returns the error", %{conn: conn} do
      id = "04f0fbd4-d231-40ea-8170-3a8cc20586bf"

      response =
        conn
        |> get(Routes.users_path(conn, :delete, id))
        |> response(:not_found)

      expected_reponse = "{\"message\":\"User not found\"}"

      assert response == expected_reponse
    end
  end

  describe "update/2" do
    test "when all params are valid, updates the user", %{conn: conn} do
      id = "04f0fbd4-d231-40ea-8170-3a8cc20586bf"

      params = %{"name" => "Capivara", "email" => "capivara@email.com"}

      insert(:user)

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "address" => "Rua teste, 110",
          "age" => 23,
          "cep" => "13355000",
          "cpf" => "12345678900",
          "email" => "capivara@email.com",
          "id" => "04f0fbd4-d231-40ea-8170-3a8cc20586bf",
          "name" => "Capivara",
          "city" => "Elias Fausto",
          "uf" => "SP"
        }
      }

      assert response == expected_response
    end

    test "when there is no ID user, returns the error", %{conn: conn} do
      id = "b04f0d8a-6977-4b40-b6cf-40bd0a64f764"

      params = %{"name" => "Capivara", "email" => "capivara@email.com"}

      insert(:user)

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:not_found)

      expected_resonse = %{"message" => "User not found"}

      assert response == expected_resonse
    end
  end
end
