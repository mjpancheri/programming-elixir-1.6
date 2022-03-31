list_concat = fn list1, list2 -> list1 ++ list2 end
sum = fn a, b, c -> a + b + c end
pair_tuple_to_list = fn {a, b} -> [a, b] end

prefix = fn prefix1 -> fn prefix2 -> "#{prefix1} #{prefix2}" end end

Enum.map([1, 2, 3, 4], &(&1 + 2))
Enum.each([1, 2, 3, 4], &IO.inspect(&1))
