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

  def five_two() do
    Stream.iterate(0, &(&1+1))
    |> Stream.map(fn(x) ->
      md5("#{@code}#{x}")
    end)
    |> Stream.filter(fn(x) ->
      String.starts_with?(x, "00000")
    end)
    |> Stream.transform(%{}, fn(hash, acc) ->
      new_map = build_password(hash, acc)

      if(acc[0] && acc[1] && acc[2] && acc[3] &&
       acc[4] && acc[5] && acc[6] && acc[7]) do
         IO.inspect password_from_map(new_map)
        {:halt, new_map}
       else
         IO.inspect password_from_map(new_map)
         {[password_from_map(new_map)], new_map}
       end
    end)
    |> Enum.to_list
  end

  def password_from_map(map) do
    Enum.map(0..7, fn(i) ->
      if(map[i]) do
        map[i]
      else
        "_"
      end
    end)
    |> Enum.join
  end

  def build_password(hash, map) do
    position = String.at(hash, 5)
               |> Integer.parse
               |> case do
                 :error -> nil
                 {pos, ""} when is_integer(pos) -> pos
               end
    cond do
      not is_nil(map[position]) -> map
      position > 7 -> map
      not is_nil(position) -> Map.put(map, position, String.at(hash, 6))
      true -> map
    end
  end

  def md5(string) do
    :crypto.hash(:md5, string)
    |> Base.encode16()
  end
end
