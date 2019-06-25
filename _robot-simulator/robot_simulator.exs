defmodule Robot do
  defstruct p: {0, 0}, d: :north

  def validate_direction(direction) do
    case direction do
      :north -> {:ok, :north}
      :south -> {:ok, :south}
      :east -> {:ok, :east}
      :west -> {:ok, :west}
      nil -> {:ok, :north}
      _ -> {:error, "invalid direction"}
    end
  end

  def validate_position({x, y}) when is_integer(x) and is_integer(y), do: {:ok, {x, y}}
  def validate_position(_), do: {:error, "invalid position"}

  def step(_, {:error, reason}) do
    {:error, reason}
  end

  def step(instr, robot) do
    [l, a, r] = 'LAR'
    case instr do
      ^l -> update_dir(robot, -1)
      ^a -> advance(robot)
      ^r -> update_dir(robot, 1)
      _ -> {:error, "invalid instruction"}
    end
  end

  defp update_dir(robot, delta) do
    dirs = [:north, :east, :south, :west]
    i = Enum.find_index(dirs, fn a -> a == robot.d end)
    if i == 3 and delta == 1 do
      %{robot | d: :north}
    else
      %{robot | d: Enum.at(dirs, i + delta)}
    end
  end

  defp advance(%{d: d, p: {x, y}} = robot) do
    case d do
      :north -> %{ robot | p: {x, y + 1 }}
      :west -> %{ robot | p: {x - 1, y }}
      :east -> %{ robot | p: {x + 1, y }}
      :south -> %{ robot | p: {x, y - 1 }}
    end
  end
end


defmodule RobotSimulator do
  def create(direction, position) do
    {pstat, pos} = Robot.validate_position(position)
    {dstat, dir} = Robot.validate_direction(direction)
    if dstat == :error do {dstat, dir} else
      if pstat == :error do {pstat, pos} else
        %Robot{ d: dir, p: pos }
      end
    end
  end

  def create(), do: %Robot{}

  def simulate(robot, instructions) do
    instructions
    |> String.to_charlist
    |> Enum.reduce(robot, &Robot.step/2)
  end

  def direction(robot), do: robot.d
  def position(robot), do: robot.p
end
