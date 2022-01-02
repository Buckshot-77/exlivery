defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "when all params are valid, returns an order" do
      user = build(:user)
      # items = build_list(2, :item)
      items = [
        build(:item),
        build(:item,
          description: "Strawberry Sundae",
          category: :sobremesa,
          quantity: 2,
          unit_price: Decimal.new("12.00")
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "when there are no items in the order, returns an error" do
      user = build(:user)
      items = []

      response = Order.build(user, items)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
