defmodule Adventofcode2016.Six do
  @codes File.read!("./lib/six.txt") |> String.trim() |> String.split("\n") |> Enum.map(&String.graphemes/1)

  def six do
    @codes
    |> Enum.reduce(%{}, fn(letters, acc) ->
      Enum.with_index(letters)
      |> Enum.reduce(acc, fn({letter, index}, acc) ->
        Map.update(acc, index, %{letter => 1}, fn(map) ->
          Map.update(map, letter, 1, &(&1 + 1))
        end)
      end)
    end)
    |> Enum.reduce("", fn({_key, value}, acc) ->
      {letter, _count} = Map.to_list(value)
      |> Enum.sort_by(fn({_key, value}) -> -1 * value end)
      |> List.first

      "#{acc}#{letter}"
    end)
  end
end
