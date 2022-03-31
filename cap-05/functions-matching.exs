handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

File.open("functions.exs") |> handle_open.() |> IO.puts()
File.open("cap-05/functions.exs") |> handle_open.() |> IO.puts()

fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, thirth -> thirth
end

fizz_buzz.(0, 0, 15) |> IO.puts()
fizz_buzz.(0, 5, 15) |> IO.puts()
fizz_buzz.(3, 0, 15) |> IO.puts()
fizz_buzz.(3, 5, 15) |> IO.puts()

fizz_buzz_2 = fn n -> fizz_buzz.(rem(n, 3), rem(n, 5), n) end

fizz_buzz_2.(10) |> IO.puts()
fizz_buzz_2.(11) |> IO.puts()
fizz_buzz_2.(12) |> IO.puts()
fizz_buzz_2.(13) |> IO.puts()
fizz_buzz_2.(14) |> IO.puts()
fizz_buzz_2.(15) |> IO.puts()
fizz_buzz_2.(16) |> IO.puts()
