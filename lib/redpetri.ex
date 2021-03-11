defmodule Redpetri do

  def createPost(la, [elem]), do: insertPost(la, elem)
  def createPost(la, [head | tail]), do: createPost(insertPost(la, head), tail)
  def createPre(la, [elem]), do: insertPre(la, elem)
  def createPre(la, [head | tail]), do: createPre(insertPre(la, head), tail)

  def insertPost(nil, [h, t]), do: {h, {t, nil}, nil}
  def insertPost({v, r, d}, [h, t]), do: if v == h, do: {v, insertHorizontal(r, t), d}, else: {v, r, insertPost(d, [h, t])}
  def insertPre(nil, [h, t]), do: {t, {h, nil}, nil}
  def insertPre({v, r, d}, [h, t]), do: if v == t, do: {v, insertHorizontal(r, h), d}, else: {v, r, insertPre(d, [h, t])}

  def insertHorizontal({head, nil}, value), do: {head, {value, nil}}
  def insertHorizontal({head, tail}, value), do: {head, insertHorizontal(tail, value)}

  def simplifyTuple([]), do: []
  def simplifyTuple([{left, right}]), do: simplifyTuple(left) ++ simplifyTuple(right)
  def simplifyTuple([elem]), do: [elem]
  def simplifyTuple({left, nil}), do: [left]
  def simplifyTuple({left, right}), do: [left] ++ simplifyTuple(Tuple.to_list(right))
  def simplifyTuple([head | tail]), do: if hd(tail) == nil, do: [head], else: simplifyTuple(head) ++ simplifyTuple(Tuple.to_list(hd(tail)))
  def simplifyTuple(elem), do: [elem]
end
