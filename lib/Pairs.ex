defmodule Pairs do
  @net  [[P0, A], [A, P1], [A, P2], [P1, B], [P1, D], [P2, C], [P2, D], [B, P3], [C, P4], [D, P3], [D, P4], [P3, E], [P4, E], [E, P5]]
  @netCiclo [[P0, A], [A, P1], [A, P2], [P1, B], [B, P3], [P3, E], [P2, C], [C, P4], [P4, D], [D, P2], [P4, E], [E, P5]]
  @test [[P0, A], [A, P1], [A, P2], [P1, B], [P1, D], [P2, C], [P2, D], [B, P3], [D, P3], [C, P4], [P3, E], [P4, E], [E, P5]]

  def getNet, do: @net
  def getNetCiclo, do: @netCiclo
  def getTest, do: @test

  def postSet(net, elem), do: net |> Enum.filter(fn [a, _b] -> a == elem end) |> Enum.map(fn [_a, b] -> b end) |> MapSet.new()
  def preSet(net, elem), do: net |> Enum.filter(fn [_a, b] -> b == elem end) |> Enum.map(fn [a, _b] -> a end) |> MapSet.new()

  def fire(net, mark, elem) do
    if(MapSet.subset?(preSet(net, elem), MapSet.new(mark))) do
      MapSet.difference(MapSet.new(mark), preSet(net, elem)) |> MapSet.union(postSet(net, elem))
    else
      mark
    end
  end

  def enablement(net, mark) do
    mark |> Enum.map(fn x -> postSet(net, x) |> MapSet.to_list end) |> List.flatten
    |> Enum.filter(fn x -> MapSet.subset?(preSet(net,x), MapSet.new(mark)) end) |> MapSet.new()
  end
  
  # def traversal(_net, _mark, []), do: true
  # def traversal(net, mark, [head | tail]) do
  #   if(fire(net, mark, ("Elixir."<> head |> String.to_atom )) == MapSet.new(mark)) do
  #     false
  #   else
  #     traversal(net, fire(net, mark, ("Elixir."<> head |> String.to_atom )), tail)
  #   end
  #
  # end
  #
  # def replay(net, mark, name) do
  #   File.read!(name) |> String.split |> Enum.map(fn line -> String.split(line, ",") end) |>
  #   Enum.map(fn line -> traversal(net, mark, line) end)
  # end
  #
  #
  # def reachability_graph(net, mark) do
  #   enablement(net, mark) |> MapSet.to_list
  #   |> Enum.map(fn x -> fire(net, mark, x) |> MapSet.to_list end)
  #   |> Enum.reduce([mark], fn x, acc -> acc ++ reachability_graph(net, x) end)
  #   |> MapSet.new |> MapSet.to_list
  # end


end
