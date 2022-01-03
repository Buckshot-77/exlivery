defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  @cpf "98856232366"

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "saves the user with valid data" do
      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when the user is found, returns the user" do
      :user
      |> build(cpf: @cpf)
      |> UserAgent.save()

      response = UserAgent.get(@cpf)

      expected_response =
        {:ok,
         %Exlivery.Users.User{
           address: "New Hanover, 344",
           age: 36,
           cpf: @cpf,
           email: "ArthurMorgan@test.com",
           name: "Arthur Morgan"
         }}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("12312312312")

      expected_response = {:error, "User not found."}

      assert response == expected_response
    end
  end
end
