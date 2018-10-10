defmodule PhoenixTransports.Supervisor do
  use Supervisor
  require Logger

  def start_link(endpoint, opts \\ []) do
    Supervisor.start_link(__MODULE__, endpoint, opts)
  end

  def init(endpoint) do
    socket_handlers =
      for {path, socket} <- endpoint.__sockets__,
        {_transport, {_module, config}} <- socket.__transports__,
        PhoenixTransports.Transport == config[:telly],
        serializer = Keyword.fetch!(config, :serializer),
        into: %{},
      do: {path, {socket, serializer}}

    phoenix_transports_spec =
      :ranch.child_spec(
        make_ref(),
        10,
        :ranch_tcp,
        [port: 5555],
        PhoenixTransports.Protocol,
        endpoint: endpoint,
        handlers: socket_handlers
      )
    
    children = [phoenix_transports_spec]

    Logger.info("Running on port 5555")
    supervise(children, strategy: :one_for_one)
  end
end
