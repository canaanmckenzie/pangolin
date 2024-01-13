defmodule Streamer.Kraken do
  use WebSockex
  require Logger

  # wss://ws-auth.kraken.com/ - needs an auth token
  @url "wss://ws.kraken.com/"

  def start_link(product_ids \\ []) do
    WebSockex.start_link(@url, __MODULE__, :no_state)
  end

  def handle_frame({type, msg}, state) do
    IO.puts "Connected!"
    {:ok, state}
  end


  def subscription_frame(products) do
    subscription_msg = %{
      event: "subscribe",
      pair: products,
      subscription: %{
        name: "ticker"
      }
    } |> Jason.encode!()

    {subscription_msg, :binary}
  end
end
