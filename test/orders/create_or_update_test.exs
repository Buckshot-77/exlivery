defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "12345678900"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Mozarella Pizza",
        quantity: 1,
        unit_price: "25.50"
      }

      item2 = %{
        category: :sobremesa,
        description: "Strawberry Sundae",
        quantity: 3,
        unit_price: "8.50"
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when a user with the given cpf is not found, returns an error", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: "1233321222", items: [item1, item2]}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "User not found."}

      assert response == expected_response
    end

    test "when an item is invalid, returns an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      assert {:error, "Invalid items"} = response
    end

    test "when there are no items, returns an error", %{
      user_cpf: cpf
    } do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)

      assert {:error, "Invalid parameters"} = response
    end
  end
end
