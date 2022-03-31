defmodule CharCount do
  def count_happy(text) do
    do_count_happy(text, %{as: 0, bs: 0})
  end

  defp do_count_happy(<<"a", rest::binary>>, counts) do
    do_count_happy(
      rest,
      Map.put(counts, :as, counts.as + 1)
    )
  end

  defp do_count_happy(<<"b", rest::binary>>, counts) do
    do_count_happy(
      rest,
      Map.put(counts, :bs, counts.bs + 1)
    )
  end

  defp do_count_happy(_, counts), do: counts

  # =============================================

  def count_sad(text) do
    do_count_sad(text, %{as: 0, bs: 0})
  end

  defp do_count_sad(text, counts) do
    cond do
      String.starts_with?(text, "a") ->
        do_count_sad(
          String.slice(text, 1..-1),
          Map.put(counts, :as, counts.as + 1)
        )

      String.starts_with?(text, "b") ->
        do_count_sad(
          String.slice(text, 1..-1),
          Map.put(counts, :bs, counts.bs + 1)
        )

      true ->
        counts
    end
  end
end
