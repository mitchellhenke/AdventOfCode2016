defmodule Adventofcode2016.Four do
  @regex ~r/(?<characters>([a-z]|-)+)(?<number>\d+)(?<checksum>\[.*\])/
  @codes File.read!("./lib/four.txt") |> String.trim |> String.split("\n") 
  |> Enum.map(fn(x) -> Regex.named_captures(@regex, x) end)
  |> Enum.map(fn(x) ->
    Map.put(x, "characters", String.replace(x["characters"], "-", ""))
    |> Map.put("checksum", String.replace(x["checksum"], ["[", "]"], ""))
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
    |> Map.to_list
    |> Enum.sort_by(fn({letter, count}) -> [-1 * count, letter] end)
    |> Enum.take(5)
    |> Enum.map(fn({letter, _count}) ->
      letter
    end)
    |> Enum.join()
  end
end
