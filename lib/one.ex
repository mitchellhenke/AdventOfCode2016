defmodule Adventofcode2016.One do
  @directions "R1, R3, L2, L5, L2, L1, R3, L4, R2, L2, L4, R2, L1, R1, L2, R3, L1, L4, R2, L5, R3, R4, L1, R2, L1, R3, L4, R5, L4, L5, R5, L3, R2, L3, L3, R1, R3, L4, R2, R5, L4, R1, L1, L1, R5, L2, R1, L2, R188, L5, L3, R5, R1, L2, L4, R3, R5, L3, R3, R45, L4, R4, R72, R2, R3, L1, R1, L1, L1, R192, L1, L1, L1, L4, R1, L2, L5, L3, R5, L3, R3, L4, L3, R1, R4, L2, R2, R3, L5, R3, L1, R1, R4, L2, L3, R1, R3, L4, L3, L4, L2, L2, R1, R3, L5, L1, R4, R2, L4, L1, R3, R3, R1, L5, L2, R4, R4, R2, R1, R5, R5, L4, L1, R5, R3, R4, R5, R3, L1, L2, L4, R1, R4, R5, L2, L3, R4, L4, R2, L2, L4, L2, R5, R1, R4, R3, R5, L4, L4, L5, L5, R3, R4, L1, L3, R2, L2, R1, L3, L5, R5, R5, R3, L4, L2, R4, R5, R1, R4, L3" |> String.split(",") |> Enum.map(fn(x) -> String.trim(x) |> String.next_grapheme() end) |> Enum.map(fn({dir, num}) -> {dir, String.to_integer(num)} end)

  def one do
    state = %{horizontal: 0, vertical: 0, facing: :north}
    Enum.reduce(@directions, state, fn(direction, state) ->
      next(direction, state)
    end)
  end

  def next(direction, state)
  def next({"R", number}, state = %{facing: :north}) do
    %{state | facing: :east, horizontal: state[:horizontal] + number}
  end
  def next({"R", number}, state = %{facing: :west}) do
    %{state | facing: :north, vertical: state[:vertical] + number}
  end
  def next({"R", number}, state = %{facing: :east}) do
    %{state | facing: :south, vertical: state[:vertical] - number}
  end
  def next({"R", number}, state = %{facing: :south}) do
    %{state | facing: :west, horizontal: state[:horizontal] - number}
  end

  def next({"L", number}, state = %{facing: :north}) do
    %{state | facing: :west, horizontal: state[:horizontal] - number}
  end
  def next({"L", number}, state = %{facing: :west}) do
    %{state | facing: :south, vertical: state[:vertical] - number}
  end
  def next({"L", number}, state = %{facing: :east}) do
    %{state | facing: :north, vertical: state[:vertical] + number}
  end
  def next({"L", number}, state = %{facing: :south}) do
    %{state | facing: :east, horizontal: state[:horizontal] + number}
  end
end
