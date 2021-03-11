defmodule ListAd do

  @pairs  [[P0, A], [A, P1], [A, P2], [P1, B], [P1, D], [P2, C], [P2, D], [B, P3], [C, P4], [D, P3], [D, P4], [P3, E], [P4, E], [E, P5]]
  @netCiclo [[P0, A], [A, P1], [A, P2], [P1, B], [B, P3], [P3, E], [P2, C], [C, P4], [P4, D], [D, P2], [P4, E], [E, P5]]
  @test [[P0, A], [A, P1], [A, P2], [P1, B], [P1, D], [P2, C], [P2, D], [B, P3], [D, P3], [C, P4], [P3, E], [P4, E], [E, P5]]

  def getNet, do: @pairs
  def getNetCiclo, do: @netCiclo
  def getNetTest, do: @test
  def getPost(net), do: Redpetri.createPost(nil, net)
  def getPre(net), do: Redpetri.createPre(nil, net)
  def getList, do: [getPre(getNet()), getPost(getNet())]
  def getListCiclo, do: [getPre(getNetCiclo()), getPost(getNetCiclo())]
  def getListTest, do: [getPre(getNetTest()), getPost(getNetTest())]

  def pSet(nil, _elem), do: MapSet.new([])
  def pSet({v, r, d}, elem) do
    if (v == elem) do
      r |> Redpetri.simplifyTuple |> MapSet.new
    else
      pSet(d, elem)
    end
  end

  def fire([preSet, postSet], mark, elem) do
    if(MapSet.subset?(pSet(preSet, elem), MapSet.new(mark))) do
      MapSet.difference(MapSet.new(mark), pSet(preSet, elem)) |> MapSet.union(pSet(postSet, elem))
    else
      mark
    end
  end

  def enablement([preSet, postSet], mark) do
    mark |> Enum.map(fn x -> pSet(postSet, x) |> MapSet.to_list end) |> List.flatten
    |> Enum.filter(fn x -> MapSet.subset?(pSet(preSet, x), MapSet.new(mark)) end) |> MapSet.new()
  end

  def traversal(_net, _mark, []), do: true
  def traversal(net, mark, [head | tail]) do
    if(fire(net, mark, ("Elixir."<> head |> String.to_atom )) == MapSet.new(mark)
    or fire(net, mark, ("Elixir."<> head |> String.to_atom )) == mark) do
      false
    else
      traversal(net, fire(net, mark, ("Elixir."<> head |> String.to_atom )), tail)
    end
  end

  def replay(net, mark, name) do
    File.read!(name) |> String.split |> Enum.map(fn line -> String.split(line, ",") end) |>
    Enum.map(fn line -> traversal(net, mark, line) end)
  end
  #
  # def reachability_graph(net, mark) do
  #   enablement(net, mark)
  #   |> MapSet.to_list
  #   |> Enum.map(fn x -> fire(net, mark, x) |> MapSet.to_list end)
  #   |> Enum.reduce([mark], fn x, acc -> acc ++ reachability_graph(net, x) end)
  #   |> MapSet.new |> MapSet.to_list
  # end

end
