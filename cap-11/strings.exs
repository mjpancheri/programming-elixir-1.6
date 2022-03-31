defmodule Strings do
  def printable(term) when is_bitstring(term) do
    false
  end

  def printable(term) do
    Enum.all?(term, &(&1 >= 32 and &1 <= 126))
  end

  def anagram?(a, a), do: is_binary(a)

  def anagram?(a, b) when is_binary(a) and is_binary(b) do
    sort_string(a) == sort_string(b)
  end

  defp sort_string(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end

  def calculate(expression) when is_bitstring(expression) do
    raise "Invalid expression"
  end

  def calculate(expression) when is_list(expression) do
    operators = '+-*/'

    operator =
      expression
      |> Enum.find(&(&1 in operators))

    to_string(expression)
    |> String.replace(" ", "")
    |> calculate(<<operator>>)
  end

  defp calculate(expression, nil) do
    raise "Invalid expression '#{expression}'"
  end

  defp calculate(expression, operator) do
    if not String.match?(expression, ~r/\d+(\+|\-|\*|\/)\d+/) do
      raise "Invalid expression: '#{expression}'"
    end

    [arg1, arg2] = String.split(expression, operator)

    calculate(String.to_integer(arg1), String.to_integer(arg2), operator)
  end

  defp calculate(arg1, arg2, operator) do
    case operator do
      "+" -> arg1 + arg2
      "-" -> arg1 - arg2
      "*" -> arg1 * arg2
      "/" -> arg1 / arg2
    end
  end
end
