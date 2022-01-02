defmodule Exlivery.Factory do
  use ExMachina

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
end
