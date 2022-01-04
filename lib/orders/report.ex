defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  def create(filename \\ "report.csv") do
    filename = "reports/#{filename}"
    order_list = build_order_list()

    File.write(filename, order_list)
  end

  defp build_order_list do
    OrderAgent.list_orders()
    |> Map.values()
    |> Enum.map(&convert_order_to_string(&1))
  end

  defp convert_order_to_string(%Order{user_cpf: cpf, items: items, total_price: total_price}) do
    item_string_list = Enum.map(items, fn item -> convert_item_to_string(item) end)
    "#{cpf},#{item_string_list},#{total_price}\n"
  end

  defp convert_item_to_string(%Item{
         category: category,
         quantity: quantity,
         unit_price: unit_price
       }) do
    "#{category},#{quantity},#{unit_price}"
  end
end
