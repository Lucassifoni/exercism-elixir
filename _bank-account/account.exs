defmodule BankServer do
  use GenServer

  @name :bank_account_server

  def init(init_arg) do
    {:ok, init_arg}
  end

  defmodule State do
    defstruct b: 0, s: :closed
  end

  # Public API
  def open() do
    {:ok, pid} = GenServer.start_link(__MODULE__, %State{}, name: @name)
    GenServer.cast(pid, :open)
    pid
  end
  def balance(account), do: GenServer.call(account, :balance)
  def update(account, amount), do: GenServer.call(account, {:update, amount})
  def close(account), do: GenServer.cast(account, :close)

  # Handlers
  def handle_call(_, _, %State{s: :closed} = s), do: {:reply, {:error, :account_closed}, s}
  def handle_call(:balance, _, %State{b: balance} = s), do: {:reply, balance, s}
  def handle_call({:update, amount}, _, %State{b: balance, s: :open} = s), do: {:reply, balance + amount, %State{s | b: balance + amount}}
  def handle_cast(:open, s), do: {:noreply, %State{s | s: :open }}
  def handle_cast(:close, s), do: {:noreply, %State{s | s: :closed }}
end

defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank(), do: BankServer.open()

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account), do: BankServer.close(account)

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account), do: BankServer.balance(account)

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount), do: BankServer.update(account, amount)
end
