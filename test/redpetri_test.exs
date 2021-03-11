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

  test "enablement Pairs con [P1, P4]" do
    assert Pairs.enablement(Pairs.getNet, [P1, P4]) == MapSet.new([B])
  end

  test "enablement Pairs con [P1, P2]" do
    assert Pairs.enablement(Pairs.getNet, [P1, P2]) == MapSet.new([B, C, D])
  end

  test "enablement ListAd con [P1, P4]" do
    assert ListAd.enablement(ListAd.getList, [P1, P4]) == MapSet.new([B])
  end

  test "enablement ListAd con [P1, P2]" do
    assert ListAd.enablement(ListAd.getList, [P1, P2]) == MapSet.new([B, C, D])
  end

  test "Pairs replay 1" do
    assert Pairs.replay(Pairs.getNetCiclo, [P0], "log1.txt") == [true, true, true, true, true, false, false, false, true, false]
  end

  test "ListAd replay 1" do
    assert ListAd.replay(ListAd.getListCiclo, [P0], "log1.txt") == [true, true, true, true, true, false, false, false, true, false]
  end

  test "Pairs replay 2" do
    assert Pairs.replay(Pairs.getNet, [P0], "log2.txt") == [false, true, true, false, false]
  end

  test "ListAd replay 2" do
    assert ListAd.replay(ListAd.getList, [P0], "log2.txt") == [false, true, true, false, false]
  end


end
