defmodule Adventofcode2016.Three do
  @triangles File.read!("./lib/three.txt") |> String.trim |> String.split("\n")
  |> Enum.map(fn(numbers) -> String.split(numbers) |> Enum.map(&String.to_integer/1) end)

  def three do
    Enum.filter(@triangles, &valid_triangle?/1)
  end

  def valid_triangle?([a, b, c]) when a + b <= c, do: false
  def valid_triangle?([a, b, c]) when c + a <= b, do: false
  def valid_triangle?([a, b, c]) when c + b <= a, do: false
  def valid_triangle?(_), do: true
end
