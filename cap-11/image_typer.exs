defmodule ImageTyper do
  @png_signature <<137::size(8), 80::size(8), 78::size(8), 71::size(8), 13::size(8), 10::size(8),
                   26::size(8), 10::size(8)>>
  @jpg_signature <<255::size(8), 216::size(8)>>

  def type(file_name) do
    file_name
    |> read_file()
    |> _type()
  end

  def read_file(file_name) do
    case File.read(file_name) do
      {:ok, file} ->
        file

      _ ->
        IO.puts("Couldn't open #{file_name}")
        []
    end
  end

  defp _type(<<@png_signature, _rest::binary>>), do: :png
  defp _type(<<@jpg_signature, _rest::binary>>), do: :jpg
  defp _type(_), do: :unknown
end
