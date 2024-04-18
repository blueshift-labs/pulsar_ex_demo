defmodule PulsarEx.Demo.Consumers.BatchedWithDLQ do
  use PulsarEx.Consumer,
    batch_size: 5,
    poll_interval: 200,
    subscription_type: :shared,
    receiving_queue_size: 500,
    redelivery_policy: :exp,
    max_redelivery_attempts: 3,
    redelivery_interval: 1000,
    dead_letter_topic: "persistent://dlq/consumers/dlq"

  require Logger

  @impl PulsarEx.ConsumerCallback
  def handle_messages(messages, %PulsarEx.Consumer{topic: topic} = _consumer) do
    Logger.info("[#{__MODULE__}] received #{Enum.count(messages)} messages from #{topic}")

    [{:error, "error"}]
  end
end
