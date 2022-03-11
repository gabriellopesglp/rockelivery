defmodule Rockelivery.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add_if_not_exists(:city, :string)
      add_if_not_exists(:uf, :string)
    end
  end
end
