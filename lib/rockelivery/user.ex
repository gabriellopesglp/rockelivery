defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:address, :age, :cep, :email, :password, :cpf, :name, :city, :uf]

  @build_params @required_params -- [:city, :uf]

  @update_params @required_params -- [:password]

  # Quando chamar o user na view só vai retornar no JSON os items a baixo
  @derive {Jason.Encoder, only: [:id, :name, :email, :cpf, :age, :cep, :address, :city, :uf]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :city, :string
    field :uf, :string

    has_many :orders, Order

    timestamps()
  end

  # Usar a validação do changeset sem ter que ir no banco de dados -> apply_action
  def build(params) do
    params
    |> changeset_build()
    |> apply_action(:create)
  end

  def changeset_build(params) do
    %__MODULE__{}
    |> validations(params, @build_params)
  end

  def changeset(params) do
    %__MODULE__{}
    |> validations(params, @required_params)
  end

  def changeset(user, params) do
    user
    |> validations(params, @update_params)
  end

  defp validations(struct, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:uf, is: 2)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
