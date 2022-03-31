defmodule Fibonacci do
  def position(1), do: 0
  def position(2), do: 1

  def position(n) when is_integer(n) and n > 0 do
    position(n - 1) + position(n - 2)
  end

  def list(1), do: [1]

  def list(n) when is_integer(n) and n > 1 do
    list = [1, 1]
    fib(list, n)
  end

  defp fib(list, 2) do
    Enum.reverse(list)
  end

  defp fib(list, n) do
    [head | tail] = list
    fib([head + hd(tail)] ++ list, n - 1)
  end
end
