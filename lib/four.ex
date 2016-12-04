defmodule Adventofcode2016.Four do
  @regex ~r/(?<characters>([a-z]|-)+)(?<number>\d+)(?<checksum>\[.*\])/
  @codes File.read!("./lib/four.txt") |> String.trim |> String.split("\n") 
  |> Enum.map(fn(x) -> Regex.named_captures(@regex, x) end)
  |> Enum.map(fn(x) ->
    Map.put(x, "checksum", String.replace(x["checksum"], ["[", "]"], ""))
    |> Map.put("number", String.to_integer(x["number"]))
  end)

  def four do
    Enum.map(@codes, fn(x) ->
      Map.put(x, "calculated_checksum", Adventofcode2016.Four.count_letters(x["characters"]))
    end)
    |> Enum.filter(fn(x) ->
      x["calculated_checksum"] == x["checksum"]
    end)
    |> Enum.reduce(0, fn(x, acc) ->
      acc + x["number"]
    end)
  end

  def count_letters(string) do
    String.graphemes(string)
    |> Enum.reduce(%{}, fn(letter, acc) ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
    |> Map.delete("-")
    |> Map.to_list
    |> Enum.sort_by(fn({letter, count}) -> [-1 * count, letter] end)
    |> Enum.take(5)
    |> Enum.map(fn({letter, _count}) ->
      letter
    end)
    |> Enum.join()
  end

  def four_two do
    Enum.map(@codes, fn(x) ->
      Map.put(x, "shifted", shift_string(x["characters"], x["number"]))
    end)
    |> Enum.filter(fn(x) -> String.contains?(x["shifted"], "pole") end)
  end

  def shift_string(string, number) do
    String.graphemes(string)
    |> Enum.map(fn(char) ->
      Enum.reduce(1..number, char, fn(_, acc) ->
        shift(acc)
      end)
    end)
    |> Enum.join
  end

  def shift(" "), do: " "
  def shift("-"), do: " "
  def shift("a"), do: "b"
  def shift("b"), do: "c"
  def shift("c"), do: "d"
  def shift("d"), do: "e"
  def shift("e"), do: "f"
  def shift("f"), do: "g"
  def shift("g"), do: "h"
  def shift("h"), do: "i"
  def shift("i"), do: "j"
  def shift("j"), do: "k"
  def shift("k"), do: "l"
  def shift("l"), do: "m"
  def shift("m"), do: "n"
  def shift("n"), do: "o"
  def shift("o"), do: "p"
  def shift("p"), do: "q"
  def shift("q"), do: "r"
  def shift("r"), do: "s"
  def shift("s"), do: "t"
  def shift("t"), do: "u"
  def shift("u"), do: "v"
  def shift("v"), do: "w"
  def shift("w"), do: "x"
  def shift("x"), do: "y"
  def shift("y"), do: "z"
  def shift("z"), do: "a"
end
