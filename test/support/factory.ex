defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "Arthur Morgan",
      email: "ArthurMorgan@test.com",
      cpf: "12345678900",
      age: 36,
      address: "New Hanover, 344"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Mozarella Pizza",
      quantity: 1,
      unit_price: Decimal.new("25.0")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "New Hanover, 344",
      items: [
        build(:item),
        build(:item,
          description: "Strawberry Sundae",
          category: :sobremesa,
          quantity: 2,
          unit_price: Decimal.new("12.00")
        )
      ],
      total_price: Decimal.new("49.00"),
      user_cpf: "12345678900"
    }
  end
end
