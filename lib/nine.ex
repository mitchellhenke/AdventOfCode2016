defmodule Adventofcode2016.Nine do
  @text File.read!("./lib/nine.txt") |> String.trim

  def nine do
    decompress(@text)
  end

  def decompress(string) do
    String.graphemes(string)
    |> do_decompress("")
  end

  def do_decompress([], acc), do: acc
  def do_decompress(["(" | rest], acc) do
    {decompress_command, [")" | rest]} = Enum.split_while(rest, fn(x) -> x != ")" end)

    [length, times] = Enum.join(decompress_command)
                      |> String.split("x")
    length = String.to_integer(length)
    times = String.to_integer(times)

    {to_be_duplicated, rest} = Enum.split(rest, length)
    to_be_duplicated = Enum.join(to_be_duplicated)
    decompressed = String.duplicate(to_be_duplicated, times)
    do_decompress(rest, acc <> decompressed)
  end

  def do_decompress([character | rest], acc) do
    do_decompress(rest, acc <> character)
  end
end
