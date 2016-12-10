defmodule Adventofcode2016.Nine do
  @text File.read!("./lib/nine.txt") |> String.trim

  def nine do
    decompress(@text)
  end

  def nine_two do
    decompress_two(@text)
  end

  def decompress(string) do
    String.graphemes(string)
    |> do_decompress("")
  end

  def decompress_two(string) do
    do_decompress_two(string, 0)
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

  defp do_decompress_two(raw, count)

  defp do_decompress_two("", count), do: count

  defp do_decompress_two(<<"(", rest::binary>>, count) do
    [counts, rest] = String.split(rest, ")", parts: 2)
    [num, times] = counts |> String.split("x") |> Enum.map(&String.to_integer/1)
    {compressed, rest} = String.split_at(rest, num)

    do_decompress_two(String.duplicate(compressed, times) <> rest, count)
  end

  defp do_decompress_two(<<_::binary-size(1), rest::binary>>, count) do
    do_decompress_two(rest, count + 1)
  end
end
