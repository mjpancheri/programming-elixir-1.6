defmodule Greeter do
  def for(name, greeting) do
    fn
      ^name ->
        "#{greeting} #{name}"

      _ ->
        "I don't know you"
    end
  end
end
