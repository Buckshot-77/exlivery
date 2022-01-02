defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all parameters are valid, returns the user" do
      response =
        User.build(
          "Arthur Morgan",
          "ArthurMorgan@test.com",
          "New Hanover, 344",
          "12345678900",
          36
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when invalid parameters are given, returns an error" do
      response =
        User.build(
          "Arthur Morgan",
          "ArthurMorgan@test.com",
          "New Hanover, 344",
          "12345678900",
          11
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
