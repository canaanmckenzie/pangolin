defmodule Streamer.Kraken do
  use WebSockex

  # wss://ws-auth.kraken.com/ - needs an auth token

  @stream_endpoint "wss://ws.kraken.com/"

  def start_link(symbol) do
    symbol = String.downcase(symbol)

    WebSockex.start_link(
      "#{@stream_endpoint}#{symbol}@trade",
      __MODULE__,
      nil
    )
  end

  def handle_frame({type, msg}, state) do
    IO.puts "Received Message - Type: #{inspect type} -- Message: #{inspect msg}"
    
  end

  @doc """
  for sending messages back to binance (using the binance REST API instead to place orders
  """
  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts "Sending #{type} frame with payload: #{msg}"
    {:reply, frame, state}
  end
end
