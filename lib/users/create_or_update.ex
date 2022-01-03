defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  def call(%{name: name, address: address, email: email, cpf: cpf, age: age}) do
    User.build(name, email, address, cpf, age)
    |> save_user()
  end

  def call(_), do: {:error, "Invalid parameters!"}

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "User created or updated successfully!"}
  end

  defp save_user({:error, _detail} = error), do: error
end
