defmodule Adventofcode2016.Seven do
  @codes File.read!("./lib/seven.txt") |> String.trim() |> String.split("\n")
  @test File.read!("./lib/seven_test.txt") |> String.trim() |> String.split("\n")

  # captures two letters, then matches them reversed
  @reversed_letter_regex ~r/([a-z])([a-z])\2\1/

  def seven do
    Enum.map(@codes, fn(x) ->
      split = String.split(x, ["[", "]"])
      outside_brackets = Enum.with_index(split)
                         |> Enum.filter(fn({_string, index}) -> rem(index, 2) == 0 end)
                         |> Enum.map(fn({string, _index}) -> string end)

      inside_brackets = Enum.with_index(split)
                         |> Enum.filter(fn({_string, index}) -> rem(index, 2) == 1 end)
                         |> Enum.map(fn({string, _index}) -> string end)

      {outside_brackets, inside_brackets}
    end)
    |> Enum.filter(fn({outside, inside}) ->
      !Enum.any?(inside, &(string_contains_reversed_letters?(&1))) && Enum.any?(outside, &(string_contains_reversed_letters?(&1)))
    end)
    |> Enum.count
  end

  def string_contains_reversed_letters?(string) do
    Regex.run(@reversed_letter_regex, string)
    |> case do
      nil -> nil
      [_string, a, a] -> nil
      [_string, a, b] -> [a, b]
    end
  end
end
