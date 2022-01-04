defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected_response =
        "12345678900,pizza,1,25.0sobremesa,2,12.00,49.00\n12345678900,pizza,1,25.0sobremesa,2,12.00,49.00\n"

      filename = "report_test.csv"
      Report.create(filename)
      filepath = "reports/#{filename}"

      response = File.read!(filepath)

      assert response == expected_response

      File.rm!(filepath)
    end
  end
end
