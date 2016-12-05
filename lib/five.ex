defmodule Adventofcode2016.Five do
  @code "ojvtpuvg"

  def five() do
    Stream.iterate(0, &(&1+1))
    |> Stream.map(fn(x) ->
      md5("#{@code}#{x}")
    end)
    |> Stream.filter_map(fn(x) ->
      String.starts_with?(x, "00000")
    end, fn(x) ->
      String.at(x, 5)
    end)
    |> Enum.take(8)
    |> Enum.join()
  end

  def md5(string) do
    :crypto.hash(:md5, string)
    |> Base.encode16()
  end
end
