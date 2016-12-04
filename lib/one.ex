defmodule Adventofcode2016.One do
  @directions "R1, R3, L2, L5, L2, L1, R3, L4, R2, L2, L4, R2, L1, R1, L2, R3, L1, L4, R2, L5, R3, R4, L1, R2, L1, R3, L4, R5, L4, L5, R5, L3, R2, L3, L3, R1, R3, L4, R2, R5, L4, R1, L1, L1, R5, L2, R1, L2, R188, L5, L3, R5, R1, L2, L4, R3, R5, L3, R3, R45, L4, R4, R72, R2, R3, L1, R1, L1, L1, R192, L1, L1, L1, L4, R1, L2, L5, L3, R5, L3, R3, L4, L3, R1, R4, L2, R2, R3, L5, R3, L1, R1, R4, L2, L3, R1, R3, L4, L3, L4, L2, L2, R1, R3, L5, L1, R4, R2, L4, L1, R3, R3, R1, L5, L2, R4, R4, R2, R1, R5, R5, L4, L1, R5, R3, R4, R5, R3, L1, L2, L4, R1, R4, R5, L2, L3, R4, L4, R2, L2, L4, L2, R5, R1, R4, R3, R5, L4, L4, L5, L5, R3, R4, L1, L3, R2, L2, R1, L3, L5, R5, R5, R3, L4, L2, R4, R5, R1, R4, L3" |> String.split(",") |> Enum.map(fn(x) -> String.trim(x) |> String.next_grapheme() end) |> Enum.map(fn({dir, num}) -> {dir, String.to_integer(num)} end)

  @test "R8, R4, R4, R8" |> String.split(",") |> Enum.map(fn(x) -> String.trim(x) |> String.next_grapheme() end) |> Enum.map(fn({dir, num}) -> {dir, String.to_integer(num)} end)


  def one do
    state = %{visited_spots: MapSet.new, x: 0, y: 0, facing: :north}
    Enum.reduce(@directions, state, fn(direction, state) ->
      new_state = next(direction, state)
      beginning_x = cond do
        state.x == new_state.x -> state.x
        new_state.x > state.x -> state.x + 1
        new_state.x < state.x -> state.x - 1
      end

      beginning_y = cond do
        state.y == new_state.y -> state.y
        new_state.y > state.y -> state.y + 1
        new_state.y < state.y -> state.y - 1
      end
      visited_spots = Enum.reduce(beginning_x..new_state.x, MapSet.new, fn(x, acc) ->
        Enum.reduce(beginning_y..new_state.y, acc, fn(y, acc) ->
          MapSet.put(acc, {x, y})
        end)
      end)

      if(Set.size(Set.intersection(new_state[:visited_spots], visited_spots)) > 0) do
        throw Set.intersection(new_state[:visited_spots], visited_spots)
      else
        Map.put(new_state, :visited_spots, Set.union(new_state[:visited_spots], visited_spots))
      end
    end)
  end

  def next(direction, state)
  def next({"R", number}, state = %{facing: :north}) do
    %{state | facing: :east, x: state[:x] + number}
  end
  def next({"R", number}, state = %{facing: :west}) do
    %{state | facing: :north, y: state[:y] + number}
  end
  def next({"R", number}, state = %{facing: :east}) do
    %{state | facing: :south, y: state[:y] - number}
  end
  def next({"R", number}, state = %{facing: :south}) do
    %{state | facing: :west, x: state[:x] - number}
  end

  def next({"L", number}, state = %{facing: :north}) do
    %{state | facing: :west, x: state[:x] - number}
  end
  def next({"L", number}, state = %{facing: :west}) do
    %{state | facing: :south, y: state[:y] - number}
  end
  def next({"L", number}, state = %{facing: :east}) do
    %{state | facing: :north, y: state[:y] + number}
  end
  def next({"L", number}, state = %{facing: :south}) do
    %{state | facing: :east, x: state[:x] + number}
  end
end
