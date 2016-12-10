defmodule Adventofcode2016.Ten do
  @commands File.read!("./lib/ten.txt") |> String.trim |> String.split("\n") |> Enum.map(&String.split(&1))

  def ten do
    result = Enum.reduce(@commands, %{}, fn(command, acc) ->
      do_setup_command(command, acc)
    end)

    do_command(@commands, result)
    |> Enum.filter(fn({key, val}) ->
      String.starts_with?(key, "bot") && Enum.member?(val, 61) && Enum.member?(val, 17)
    end)
  end

  def ten_two do
    result = Enum.reduce(@commands, %{}, fn(command, acc) ->
      do_setup_command(command, acc)
    end)

    output = do_command(@commands, result)
    IO.inspect(output["output0"], char_lists: false)
    IO.inspect(output["output1"], char_lists: false)
    IO.inspect(output["output2"], char_lists: false)
  end

  def do_command([], state) do
    state
  end

  def do_command([["value", _value, "goes", "to", "bot", _bot] | rest], state) do
    do_command(rest, state)
  end

  def do_command([["bot", give_bot, "gives", "low", "to", type_low, take_low, "and", "high", "to", type_high, take_high] | rest], state) do
    IO.inspect give_bot
    case state["bot#{give_bot}"] do
      [_one | [_two]] ->
        new_state =
          process_command(give_bot, type_low, take_low, type_high, take_high, state)

          do_command(rest, new_state)
      _  ->
        do_command(rest ++ [["bot", give_bot, "gives", "low", "to", type_low, take_low, "and", "high", "to", type_high, take_high]], state)
    end
  end

  def process_command(give_bot, type_low, take_low, type_high, take_high, state) do
    [low | [high]] = Enum.sort(Map.get(state, "bot#{give_bot}"))

    current = state["#{type_low}#{take_low}"] || []
    new_state = Map.put(state, "#{type_low}#{take_low}", [low | current])

    current = state["#{type_high}#{take_high}"] || []
    Map.put(new_state, "#{type_high}#{take_high}", [high | current])
  end

  def do_setup_command(["value", value, "goes", "to", "bot", bot], state) do
    current = state["bot#{bot}"] || []
    Map.put(state, "bot#{bot}", [String.to_integer(value) | current])
  end

  def do_setup_command(_, state) do
    state
  end
end
