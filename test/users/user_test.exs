defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all parameters are valid, returns the user" do
      response =
        User.build(
          "Jonas",
          "Jonas@test.com",
          "Rua Laranjeiras",
          "123456789",
          30
        )

      expected_response =
        {:ok,
         %User{
           address: "Rua Laranjeiras",
           age: 30,
           cpf: "123456789",
           email: "Jonas@test.com",
           name: "Jonas"
         }}

      assert response == expected_response
    end

    test "when invalid parameters are given, returns an error" do
      response =
        User.build(
          "Jonas",
          "Jonas@test.com",
          "Rua Laranjeiras",
          "123456789",
          15
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
