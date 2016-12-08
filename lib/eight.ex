defmodule Adventofcode2016.Eight do
  @row_length 50
  @column_length 6
  @starting_matrix Enum.map(1..(@row_length*@column_length), fn(_) -> 0 end)
  @commands File.read!("./lib/eight.txt") |> String.trim() |> String.split("\n") |> Enum.map(fn(x) -> String.split(x) end)
  @test File.read!("./lib/eight_test.txt") |> String.trim() |> String.split("\n") |> Enum.map(fn(x) -> String.split(x) end)

  def eight do
    commands = Enum.map(@commands, &parse_command/1)
    Enum.reduce(commands, @starting_matrix, fn(command, matrix) ->
      handle_command(command, matrix)
    end)
    |> Enum.filter(&(&1 == 1))
    |> Enum.count
  end

  def eight_two do
    commands = Enum.map(@commands, &parse_command/1)
    Enum.reduce(commands, @starting_matrix, fn(command, matrix) ->
      handle_command(command, matrix)
    end)
    |> pretty_print_matrix
  end

  def parse_command(["rect", size]) do
    [col, row] = String.split(size, "x")
                 |> Enum.map(&String.to_integer/1)
    indices = Enum.flat_map(0..(col-1), fn(col) ->
      Enum.map(0..(row-1), fn(row) ->
        (row * @row_length) + col
      end)
    end)
    {:rect, indices}
  end

  # rotate column x=1 by 1
  # 1, 8, 15
  # 15, 1, 8
  def parse_command(["rotate", "column", column, "by", distance]) do
    ["x", column] = String.split(column, "=")
    column = String.to_integer(column)
    distance = String.to_integer(distance)

    column_indices = Enum.map(0..(@column_length - 1), fn(x) ->
      column + (@row_length * x)
    end)

    replacing_indices = right_rotate(column_indices, distance)

    {:rotate, {column_indices, replacing_indices}}
  end

  def parse_command(["rotate", "row", row, "by", distance]) do
    ["y", row] = String.split(row, "=")
    row = String.to_integer(row)
    distance = String.to_integer(distance)

    row_indices = Enum.map(0..(@row_length - 1), fn(x) ->
      (row * @row_length) + x
    end)

    replacing_indices = right_rotate(row_indices, distance)

    {:rotate, {row_indices, replacing_indices}}
  end

  def handle_command({:rect, indices}, matrix) do
    Enum.reduce(indices, matrix, fn(index, matrix) ->
      List.replace_at(matrix, index, 1)
    end)
  end

  def handle_command({:rotate, {replace_indices, value_indices}}, matrix) do
    values = Enum.map(value_indices, fn(x) -> Enum.at(matrix, x) end)

    Enum.zip(replace_indices, values)
    |> Enum.reduce(matrix, fn({index, value}, matrix) ->
      List.replace_at(matrix, index, value)
    end)
  end

  def pretty_print_matrix(matrix) do
    Enum.map(matrix, fn(x) -> if(x == 0, do: " ", else: "1") end)
    |> Enum.chunk(@row_length)
    |> Enum.map(fn(x) -> Enum.join(x) end)
    |> Enum.each(&(IO.inspect(&1, width: 300)))
    IO.puts("\n")

    matrix
  end

  def left_rotate(l, n \\ 1)
  def left_rotate([], _), do: []
  def left_rotate(l,  0), do: l
  def left_rotate([h | t], 1), do: t ++ [h]
  def left_rotate(l, n) when n > 0, do: left_rotate(left_rotate(l, 1), n-1)
  def left_rotate(l, n), do: right_rotate(l, -n)

  def right_rotate(l, n \\ 1)
  def right_rotate(l, n) when n > 0, do: Enum.reverse(l) |> left_rotate(n) |> Enum.reverse
  def right_rotate(l, n), do: left_rotate(l, -n)
end

"""
111   1  1  111   1  1   11   1111   11   1111   111  1    
1  1  1  1  1  1  1  1  1  1  1     1  1  1       1   1    
1  1  1  1  1  1  1  1  1     111   1  1  111     1   1    
111   1  1  111   1  1  1     1     1  1  1       1   1    
1 1   1  1  1 1   1  1  1  1  1     1  1  1       1   1    
1  1   11   1  1   11    11   1111   11   1111   111  1111 
"""
