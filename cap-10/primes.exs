defmodule Primes do
  def get_primes(n) when n < 2, do: []

  def get_primes(n) do
    for x <- 2..n, is_prime?(x), do: x
  end

  defp is_prime?(n) when n in [2, 3], do: true

  defp is_prime?(n) do
    floored_sqrt =
      :math.sqrt(n)
      |> Float.floor()
      |> round

    !Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end
end
