defmodule PulsarEx.Demo.Consumers.DLQ do
  use PulsarEx.Consumer, batch_size: 1

  require Logger

  @impl PulsarEx.ConsumerCallback
  def handle_messages([_], %PulsarEx.Consumer{topic: topic} = _consumer) do
    Logger.info("[#{__MODULE__}] received dead letter from #{topic}")

    [:ok]
  end
end
