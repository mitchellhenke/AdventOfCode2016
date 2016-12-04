defmodule Adventofcode2016.Three do
  @triangles File.read!("./lib/three.txt") |> String.trim |> String.split("\n")
  |> Enum.map(fn(numbers) -> String.split(numbers) |> Enum.map(&String.to_integer/1) end)

  def three do
    Enum.filter(@triangles, &valid_triangle?/1)
  end

  def three_two do
   Enum.chunk(@triangles, 3)
   |> Enum.reduce([], fn([one, two, three], acc) ->
     first_triangle = [Enum.at(one, 0), Enum.at(two, 0), Enum.at(three, 0)]
     second_triangle = [Enum.at(one, 1), Enum.at(two, 1), Enum.at(three, 1)]
     third_triangle = [Enum.at(one, 2), Enum.at(two, 2), Enum.at(three, 2)]

     [first_triangle | [second_triangle | [third_triangle | acc]]]
   end)
   |> Enum.filter(&valid_triangle?/1)
  end

  def valid_triangle?([a, b, c]) when a + b <= c, do: false
  def valid_triangle?([a, b, c]) when c + a <= b, do: false
  def valid_triangle?([a, b, c]) when c + b <= a, do: false
  def valid_triangle?(_), do: true
end
