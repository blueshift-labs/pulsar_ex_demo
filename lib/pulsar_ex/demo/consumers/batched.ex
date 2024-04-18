defmodule PulsarEx.Demo.Consumers.Batched do
  use PulsarEx.Consumer,
    batch_size: 5,
    poll_interval: 200,
    subscription_type: :shared,
    receiving_queue_size: 500

  # these options can be overridden at time of starting the consumer

  require Logger

  @impl PulsarEx.ConsumerCallback
  def handle_messages(messages, %PulsarEx.Consumer{topic: topic} = _consumer) do
    Logger.info("[#{__MODULE__}] received #{Enum.count(messages)} messages from #{topic}")

    messages
    |> Enum.map(fn _msg ->
      :ok
    end)
  end
end
