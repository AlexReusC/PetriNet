defmodule RedpetriTest do
  use ExUnit.Case
  doctest Redpetri

  test "Pairs transición habilitada" do
    assert Pairs.fire(Pairs.getNet, [P0], A) == MapSet.new([P1, P2])
  end

  test "Pairs transición no habilitada" do
    assert Pairs.fire(Pairs.getNet, [P0], B) == [P0]
  end

  test "ListAd transición habilitada" do
    assert ListAd.fire(ListAd.getList, [P0], A) == MapSet.new([P1, P2])
  end

  test "ListAd transición no habilitada" do
    assert ListAd.fire(ListAd.getList, [P0], B) == [P0]
  end

end
