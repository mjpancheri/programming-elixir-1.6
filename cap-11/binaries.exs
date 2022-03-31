defmodule Binaries do
  # binary representa uma sequencia de bits
  # O termo mais simples é apenas um número de 0 a 255.
  # Os números são armazenados como bytes sucessivos no binário.
  # << 42 >>
  # b = << 1, 2, 3 >>
  # byte_size b # => 3
  # bit_size b # => 24

  # b = << 1::size(2), 1::size(3) >> # 01 001
  # <<9::size(5)>>

  # Vamos terminar uma olhada inicial nos binários com um exemplo de extração de bits.
  # Um float IEEE 754 tem:
  #  - 1 bit de sinal,
  #  - 11 bits de expoente
  #  - 52 bits de mantissa.
  # O expoente é enviesado por 1023, e a mantissa é uma fração com o bit superior assumido como 1.

  # << sign::size(1), exp::size(11), mantissa::size(52) >> = << 3.14159::float >>
  # (1 + mantissa / :math.pow(2, 52)) * :math.pow(2, exp-1023) * (1 - 2*sign)

  # Strings com aspas simples são armazenadas como char lists.
  # String com aspas duplas são armazenadas como sequencias de bytes (consecutivos) em UTF-8.
  # dqs = "∂x/∂y"

  def each(str, func), do: _each(String.next_codepoint(str), func)

  defp _each({codepoint, rest}, func) do
    func.(codepoint)
    _each(String.next_codepoint(rest), func)
  end

  defp _each(nil, _), do: []

  # Binaries.each "∂og", fn c -> IO.puts c end

  # Exercise 5:

  def center(list), do: _center(list, list, 0)

  defp _center([], list, max_len) do
    list
    |> Enum.each(&print_center(&1, max_len))
  end

  defp _center([head | tail], list, max_len) do
    max = _word_len(String.length(head), max_len)
    _center(tail, list, max)
  end

  defp print_center(word, max_len) do
    word_len = String.length(word)
    spaces = div(max_len - word_len, 2)

    word
    |> String.pad_leading(spaces + word_len)
    |> String.pad_trailing(max_len)
    |> IO.puts()
  end

  defp _word_len(len1, len2) do
    cond do
      len1 > len2 -> len1
      true -> len2
    end
  end

  # Exercise 6:

  def capitalize_sentence(sentence) do
    sentence
    |> String.split(". ")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(". ")
    |> IO.puts()
  end

  # Exercise 7:

  def apply_tax() do
    file = "cap-11/orders.csv"
    tax_rates = [NC: 0.075, TX: 0.08]

    orders =
      file
      |> read_file()
      |> parse()

    for [id: id, ship_to: state, net_amount: net] <- orders,
        do: [
          id: id,
          ship_to: state,
          net_amount: net,
          total_amount: calc_amount(net, tax_rates[state])
        ]
  end

  defp calc_amount(net, nil), do: net
  defp calc_amount(net, tax), do: net * (1 + tax)

  def read_file(file_path) do
    {:ok, file} = File.open(file_path, [:read])
    IO.stream(file, :line)
  end

  def parse(file_stream) do
    file_stream
    |> Stream.filter(&(not String.starts_with?(&1, "id")))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(&toKeywordList(&1))
  end

  def toKeywordList([id, state, net | _]) do
    id_int = String.to_integer(id)
    state_code = state |> String.slice(1, 2) |> String.to_atom()
    net_float = net |> String.slice(0, String.length(net) - 1) |> String.to_float()
    [id: id_int, ship_to: state_code, net_amount: net_float]
  end
end
