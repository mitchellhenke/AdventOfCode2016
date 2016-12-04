defmodule Adventofcode2016.Two do
  @directions """
  LURLDDLDULRURDUDLRULRDLLRURDUDRLLRLRURDRULDLRLRRDDULUDULURULLURLURRRLLDURURLLUURDLLDUUDRRDLDLLRUUDURURRULURUURLDLLLUDDUUDRULLRUDURRLRLLDRRUDULLDUUUDLDLRLLRLULDLRLUDLRRULDDDURLUULRDLRULRDURDURUUUDDRRDRRUDULDUUULLLLURRDDUULDRDRLULRRRUUDUURDULDDRLDRDLLDDLRDLDULUDDLULUDRLULRRRRUUUDULULDLUDUUUUDURLUDRDLLDDRULUURDRRRDRLDLLURLULDULRUDRDDUDDLRLRRDUDDRULRULULRDDDDRDLLLRURDDDDRDRUDUDUUDRUDLDULRUULLRRLURRRRUUDRDLDUDDLUDRRURLRDDLUUDUDUUDRLUURURRURDRRRURULUUDUUDURUUURDDDURUDLRLLULRULRDURLLDDULLDULULDDDRUDDDUUDDUDDRRRURRUURRRRURUDRRDLRDUUULLRRRUDD
  DLDUDULDLRDLUDDLLRLUUULLDURRUDLLDUDDRDRLRDDUUUURDULDULLRDRURDLULRUURRDLULUDRURDULLDRURUULLDLLUDRLUDRUDRURURUULRDLLDDDLRUDUDLUDURLDDLRRUUURDDDRLUDDDUDDLDUDDUUUUUULLRDRRUDRUDDDLLLDRDUULRLDURLLDURUDDLLURDDLULLDDDRLUDRDDLDLDLRLURRDURRRUDRRDUUDDRLLUDLDRLRDUDLDLRDRUDUUULULUDRRULUDRDRRLLDDRDDDLULURUURULLRRRRRDDRDDRRRDLRDURURRRDDULLUULRULURURDRRUDURDDUURDUURUURUULURUUDULURRDLRRUUDRLLDLDRRRULDRLLRLDUDULRRLDUDDUUURDUDLDDDUDL
  RURDRUDUUUUULLLUULDULLLDRUULURLDULULRDDLRLLRURULLLLLLRULLURRDLULLUULRRDURRURLUDLULDLRRULRDLDULLDDRRDLLRURRDULULDRRDDULDURRRUUURUDDURULUUDURUULUDLUURRLDLRDDUUUUURULDRDUDDULULRDRUUURRRDRLURRLUUULRUDRRLUDRDLDUDDRDRRUULLLLDUUUULDULRRRLLRLRLRULDLRURRLRLDLRRDRDRLDRUDDDUUDRLLUUURLRLULURLDRRULRULUDRUUURRUDLDDRRDDURUUULLDDLLDDRUDDDUULUDRDDLULDDDDRULDDDDUUUURRLDUURULRDDRDLLLRRDDURUDRRLDUDULRULDDLDDLDUUUULDLLULUUDDULUUDLRDRUDLURDULUDDRDRDRDDURDLURLULRUURDUDULDDLDDRUULLRDRLRRUURRDDRDUDDLRRLLDRDLUUDRRDDDUUUDLRRLDDDUDRURRDDUULUDLLLRUDDRULRLLLRDLUDUUUUURLRRUDUDDDDLRLLULLUDRDURDDULULRDRDLUDDRLURRLRRULRL
  LDUURLLULRUURRDLDRUULRDRDDDRULDLURDDRURULLRUURRLRRLDRURRDRLUDRUUUULLDRLURDRLRUDDRDDDUURRDRRURULLLDRDRDLDUURLDRUULLDRDDRRDRDUUDLURUDDLLUUDDULDDULRDDUUDDDLRLLLULLDLUDRRLDUUDRUUDUDUURULDRRLRRDLRLURDRURURRDURDURRUDLRURURUUDURURUDRURULLLLLUDRUDUDULRLLLRDRLLRLRLRRDULRUUULURLRRLDRRRDRULRUDUURRRRULDDLRULDRRRDLDRLUDLLUDDRURLURURRLRUDLRLLRDLLDRDDLDUDRDLDDRULDDULUDDLLDURDULLDURRURRULLDRLUURURLLUDDRLRRUUDULRRLLRUDRDUURLDDLLURRDLRUURLLDRDLRUULUDURRDULUULDDLUUUDDLRRDRDUDLRUULDDDLDDRUDDD
  DRRDRRURURUDDDRULRUDLDLDULRLDURURUUURURLURURDDDDRULUDLDDRDDUDULRUUULRDUDULURLRULRDDLDUDLDLULRULDRRLUDLLLLURUDUDLLDLDRLRUUULRDDLUURDRRDLUDUDRULRRDDRRLDUDLLDLURLRDLRUUDLDULURDDUUDDLRDLUURLDLRLRDLLRUDRDUURDDLDDLURRDDRDRURULURRLRLDURLRRUUUDDUUDRDRULRDLURLDDDRURUDRULDURUUUUDULURUDDDDUURULULDRURRDRDURUUURURLLDRDLDLRDDULDRLLDUDUDDLRLLRLRUUDLUDDULRLDLLRLUUDLLLUUDULRDULDLRRLDDDDUDDRRRDDRDDUDRLLLDLLDLLRDLDRDLUDRRRLDDRLUDLRLDRUURUDURDLRDDULRLDUUUDRLLDRLDLLDLDRRRLLULLUDDDLRUDULDDDLDRRLLRDDLDUULRDLRRLRLLRUUULLRDUDLRURRRUULLULLLRRURLRDULLLRLDUUUDDRLRLUURRLUUUDURLRDURRDUDDUDDRDDRUD
  """ |> String.trim() |> String.split("\n") |> Enum.map(&String.graphemes/1)

  @test """
  ULL
  RRDDD
  LURDL
  UUUUD
  """ |> String.trim() |> String.split("\n") |> Enum.map(&String.graphemes/1)

  def two() do
    {_last_button, code} = Enum.reduce(@directions, {5, []}, fn(dirs, {button, code}) ->
      new_button = get_button(dirs, button)
      {new_button, [new_button | code]}
    end)

    Enum.reverse(code)
  end

  def two_two() do
    {_last_button, code} = Enum.reduce(@directions, {5, []}, fn(dirs, {button, code}) ->
      new_button = get_button_two(dirs, button)
      {new_button, [new_button | code]}
    end)

    Enum.reverse(code)
  end

  def get_button(dirs, button) do
    do_get_button(dirs, button)
  end

  def do_get_button([], button), do: button

  def do_get_button(["U" | rest], 1), do: do_get_button(rest, 1)
  def do_get_button(["L" | rest], 1), do: do_get_button(rest, 1)
  def do_get_button(["R" | rest], 1), do: do_get_button(rest, 2)
  def do_get_button(["D" | rest], 1), do: do_get_button(rest, 4)

  def do_get_button(["U" | rest], 2), do: do_get_button(rest, 2)
  def do_get_button(["L" | rest], 2), do: do_get_button(rest, 1)
  def do_get_button(["R" | rest], 2), do: do_get_button(rest, 3)
  def do_get_button(["D" | rest], 2), do: do_get_button(rest, 5)

  def do_get_button(["U" | rest], 3), do: do_get_button(rest, 3)
  def do_get_button(["L" | rest], 3), do: do_get_button(rest, 2)
  def do_get_button(["R" | rest], 3), do: do_get_button(rest, 3)
  def do_get_button(["D" | rest], 3), do: do_get_button(rest, 6)

  def do_get_button(["U" | rest], 4), do: do_get_button(rest, 1)
  def do_get_button(["L" | rest], 4), do: do_get_button(rest, 4)
  def do_get_button(["R" | rest], 4), do: do_get_button(rest, 5)
  def do_get_button(["D" | rest], 4), do: do_get_button(rest, 7)

  def do_get_button(["U" | rest], 5), do: do_get_button(rest, 2)
  def do_get_button(["L" | rest], 5), do: do_get_button(rest, 4)
  def do_get_button(["R" | rest], 5), do: do_get_button(rest, 6)
  def do_get_button(["D" | rest], 5), do: do_get_button(rest, 8)

  def do_get_button(["U" | rest], 6), do: do_get_button(rest, 3)
  def do_get_button(["L" | rest], 6), do: do_get_button(rest, 5)
  def do_get_button(["R" | rest], 6), do: do_get_button(rest, 6)
  def do_get_button(["D" | rest], 6), do: do_get_button(rest, 9)

  def do_get_button(["U" | rest], 7), do: do_get_button(rest, 4)
  def do_get_button(["L" | rest], 7), do: do_get_button(rest, 7)
  def do_get_button(["R" | rest], 7), do: do_get_button(rest, 8)
  def do_get_button(["D" | rest], 7), do: do_get_button(rest, 7)

  def do_get_button(["U" | rest], 8), do: do_get_button(rest, 5)
  def do_get_button(["L" | rest], 8), do: do_get_button(rest, 7)
  def do_get_button(["R" | rest], 8), do: do_get_button(rest, 9)
  def do_get_button(["D" | rest], 8), do: do_get_button(rest, 8)

  def do_get_button(["U" | rest], 9), do: do_get_button(rest, 6)
  def do_get_button(["L" | rest], 9), do: do_get_button(rest, 8)
  def do_get_button(["R" | rest], 9), do: do_get_button(rest, 9)
  def do_get_button(["D" | rest], 9), do: do_get_button(rest, 9)


  def get_button_two(dirs, button) do
    do_get_button_two(dirs, button)
  end

  def do_get_button_two([], button), do: button

  def do_get_button_two(["U" | rest], 1), do: do_get_button_two(rest, 1)
  def do_get_button_two(["L" | rest], 1), do: do_get_button_two(rest, 1)
  def do_get_button_two(["R" | rest], 1), do: do_get_button_two(rest, 1)
  def do_get_button_two(["D" | rest], 1), do: do_get_button_two(rest, 3)

  def do_get_button_two(["U" | rest], 2), do: do_get_button_two(rest, 2)
  def do_get_button_two(["L" | rest], 2), do: do_get_button_two(rest, 1)
  def do_get_button_two(["R" | rest], 2), do: do_get_button_two(rest, 3)
  def do_get_button_two(["D" | rest], 2), do: do_get_button_two(rest, 6)

  def do_get_button_two(["U" | rest], 3), do: do_get_button_two(rest, 1)
  def do_get_button_two(["L" | rest], 3), do: do_get_button_two(rest, 2)
  def do_get_button_two(["R" | rest], 3), do: do_get_button_two(rest, 4)
  def do_get_button_two(["D" | rest], 3), do: do_get_button_two(rest, 7)

  def do_get_button_two(["U" | rest], 4), do: do_get_button_two(rest, 4)
  def do_get_button_two(["L" | rest], 4), do: do_get_button_two(rest, 3)
  def do_get_button_two(["R" | rest], 4), do: do_get_button_two(rest, 4)
  def do_get_button_two(["D" | rest], 4), do: do_get_button_two(rest, 8)

  def do_get_button_two(["U" | rest], 5), do: do_get_button_two(rest, 5)
  def do_get_button_two(["L" | rest], 5), do: do_get_button_two(rest, 5)
  def do_get_button_two(["R" | rest], 5), do: do_get_button_two(rest, 6)
  def do_get_button_two(["D" | rest], 5), do: do_get_button_two(rest, 5)

  def do_get_button_two(["U" | rest], 6), do: do_get_button_two(rest, 2)
  def do_get_button_two(["L" | rest], 6), do: do_get_button_two(rest, 5)
  def do_get_button_two(["R" | rest], 6), do: do_get_button_two(rest, 7)
  def do_get_button_two(["D" | rest], 6), do: do_get_button_two(rest, "A")

  def do_get_button_two(["U" | rest], 7), do: do_get_button_two(rest, 3)
  def do_get_button_two(["L" | rest], 7), do: do_get_button_two(rest, 6)
  def do_get_button_two(["R" | rest], 7), do: do_get_button_two(rest, 8)
  def do_get_button_two(["D" | rest], 7), do: do_get_button_two(rest, "B")

  def do_get_button_two(["U" | rest], 8), do: do_get_button_two(rest, 4)
  def do_get_button_two(["L" | rest], 8), do: do_get_button_two(rest, 7)
  def do_get_button_two(["R" | rest], 8), do: do_get_button_two(rest, 9)
  def do_get_button_two(["D" | rest], 8), do: do_get_button_two(rest, "C")

  def do_get_button_two(["U" | rest], 9), do: do_get_button_two(rest, 9)
  def do_get_button_two(["L" | rest], 9), do: do_get_button_two(rest, 8)
  def do_get_button_two(["R" | rest], 9), do: do_get_button_two(rest, 9)
  def do_get_button_two(["D" | rest], 9), do: do_get_button_two(rest, 9)

  def do_get_button_two(["U" | rest], "A"), do: do_get_button_two(rest, 6)
  def do_get_button_two(["L" | rest], "A"), do: do_get_button_two(rest, "A")
  def do_get_button_two(["R" | rest], "A"), do: do_get_button_two(rest, "B")
  def do_get_button_two(["D" | rest], "A"), do: do_get_button_two(rest, "A")

  def do_get_button_two(["U" | rest], "B"), do: do_get_button_two(rest, 7)
  def do_get_button_two(["L" | rest], "B"), do: do_get_button_two(rest, "A")
  def do_get_button_two(["R" | rest], "B"), do: do_get_button_two(rest, "C")
  def do_get_button_two(["D" | rest], "B"), do: do_get_button_two(rest, "D")

  def do_get_button_two(["U" | rest], "C"), do: do_get_button_two(rest, 8)
  def do_get_button_two(["L" | rest], "C"), do: do_get_button_two(rest, "B")
  def do_get_button_two(["R" | rest], "C"), do: do_get_button_two(rest, "C")
  def do_get_button_two(["D" | rest], "C"), do: do_get_button_two(rest, "C")

  def do_get_button_two(["U" | rest], "D"), do: do_get_button_two(rest, "B")
  def do_get_button_two(["L" | rest], "D"), do: do_get_button_two(rest, "D")
  def do_get_button_two(["R" | rest], "D"), do: do_get_button_two(rest, "D")
  def do_get_button_two(["D" | rest], "D"), do: do_get_button_two(rest, "D")
end
