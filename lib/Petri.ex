defmodule Petri do
  #Examples of petri nets
  @net  [[P0, A], [A, P1], [A, P2], [P1, B], [P1, D], [P2, C], [P2, D], [B, P3], [C, P4], [D, P3], [D, P4], [P3, E], [P4, E], [E, P5]]
  @netCiclo [[P0, A], [A, P1], [A, P2], [P1, B], [B, P3], [P3, E], [P2, C], [C, P4], [P4, D], [D, P2], [P4, E], [E, P5]]
  @test [[P0, A], [A, P1], [A, P2], [P1, B], [P1, D], [P2, C], [P2, D], [B, P3], [D, P3], [C, P4], [P3, E], [P4, E], [E, P5]]

  #Function for retrieving the examples of petri nes
  def getNet, do: @net
  def getNetCiclo, do: @netCiclo
  def getTest, do: @test

  #Function to find elements before n
  def postSet(net, elem), do: net |> Enum.filter(
    fn [a, _b] -> a == elem end) |> Enum.map(fn [_a, b] -> b end)
    |> MapSet.new()
  #Function find elements after n
  def preSet(net, elem), do: net |> Enum.filter(
    fn [_a, b] -> b == elem end) |> Enum.map(fn [a, _b] -> a end)
    |> MapSet.new()

  #If the transition is enabled, it will change the mark according to the elem received
  def fire(net, mark, elem) do
    if(MapSet.subset?(preSet(net, elem), MapSet.new(mark))) do
      MapSet.difference(MapSet.new(mark), preSet(net, elem)) |> MapSet.union(postSet(net, elem))
    else
      mark
    end
  end

  #It will show the transitions enabled according to a net and a mark
  def enablement(net, mark) do
    mark |> Enum.map(fn x -> postSet(net, x) |> MapSet.to_list end) |> List.flatten
    |> Enum.filter(fn x -> MapSet.subset?(preSet(net,x), MapSet.new(mark)) end) |> MapSet.new()
  end

  #Auxiliary function of replay
  #It will fire the transitions that it receives
  def traversal(_net, _mark, []), do: true
  def traversal(net, mark, [head | tail]) do
    if(fire(net, mark, ("Elixir."<> head |> String.to_atom )) == MapSet.new(mark)
    or fire(net, mark, ("Elixir."<> head |> String.to_atom )) == mark) do
      false
    else
      traversal(net, fire(net, mark, ("Elixir."<> head |> String.to_atom )), tail)
    end

  end

  #Read a file and see how many of its lines are executables (that means it will be a change
  #in the mark for every elem read)
  def replay(net, mark, name) do
    lista = File.read!(name) |> String.split |> Enum.map(fn line -> String.split(line, ",") end) |>
    Enum.map(fn line -> traversal(net, mark, line) end)

    reejectuable = Enum.filter(lista, fn x -> x end) |> length
    noreejectutable = Enum.filter(lista, fn x -> !x end) |> length

    %{"reejectuable" => reejectuable, "no-reejectuable" => noreejectutable}
  end

  #Auxiliary function  for reachability graph
  def reachability_graph_memory(net, mark, memory) do
    if (MapSet.new(mark) |> MapSet.subset?(memory)) do
      []
    else
      enablement(net, mark)
      |> MapSet.to_list
      |> Enum.map(fn x -> fire(net, mark, x) |> MapSet.to_list end)
      |> Enum.reduce(
        [mark],
        fn x, acc ->
          acc  ++ reachability_graph_memory(
            net, x, MapSet.union(memory, MapSet.new(mark)))   end)
      |> MapSet.new |> MapSet.to_list
    end
  end

  #See every possible mark in a mark
  #It creates a MapSet to check if the state has been visited and avoid loops
  def reachability_graph(net, mark) do
    reachability_graph_memory(net, mark, MapSet.new([]))
  end


end
