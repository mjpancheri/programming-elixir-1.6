defmodule Chop do
  def guess(choice, small..high) do
    kick = div(small + high, 2)
    check(choice, kick, small, high)
  end

  defp check(choice, kick, _small, _high) when choice == kick do
    IO.puts("Is it #{kick}!")
  end

  defp check(choice, kick, small, _high) when choice < kick do
    IO.puts("Is it less than #{kick}!")
    high = kick
    kick = div(small + high, 2)
    check(choice, kick, small, high)
  end

  defp check(choice, kick, _small, high) do
    IO.puts("Is it more than #{kick}!")
    small = kick
    kick = div(small + high, 2)
    check(choice, kick, small, high)
  end
end
