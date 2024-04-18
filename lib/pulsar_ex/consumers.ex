defmodule PulsarEx.Demo.Consumers do
  @doc """
    demo: producer & consumer loop for batched messages
  """
  def start_batched_consumer() do
    PulsarEx.start_consumer(
      # topic
      "persistent://demo1/consumers1/batched1",
      # subscription
      "batched-consumer",
      PulsarEx.Demo.Consumers.Batched,
      # consumer_opts
      properties: [service: :demo]
    )
  end

  def produce_to_batched_consumer() do
    1..5
    |> Enum.map(fn _ ->
      Task.async(fn ->
        PulsarEx.produce(
          "persistent://demo1/consumers1/batched1",
          "test-#{:rand.uniform(1000)}",
          # message_opts
          [
            properties: %{prop1: "1", prop2: "2"},
            partition_key: "123",
            ordering_key: "321",
            event_time: DateTime.utc_now()
          ],
          # producer_opts, enabled batched producer
          batch_enabled: true
        )
      end)
    end)
    |> Task.await_many()

    :ok
  end

  @doc """
    demo: producer & regex consumer loop for batched messages
  """
  def start_batched_consumers_with_regex() do
    PulsarEx.start_consumer(
      ~r/demo.*/,
      ~r/consumers.*/,
      ~r/batched.*/,
      # subscription
      "batched-consumer",
      PulsarEx.Demo.Consumers.Batched,
      # consumer_opts
      properties: [service: :demo],
      poll_interval: 1000
    )
  end

  def produce_to_batched_consumers_with_regex() do
    1..100
    |> Enum.map(fn _ ->
      Task.async(fn ->
        PulsarEx.produce(
          "persistent://demo#{:rand.uniform(2)}/consumers#{:rand.uniform(2)}/batched#{:rand.uniform(2)}",
          "test-#{:rand.uniform(1000)}",
          # message_opts
          [
            properties: %{prop1: "1", prop2: "2"},
            partition_key: "123",
            ordering_key: "321",
            event_time: DateTime.utc_now()
          ],
          # producer_opts, enabled batched producer
          max_queue_size: 1000
        )
      end)
    end)
    |> Task.await_many()

    :ok
  end

  @doc """
    demo: producer & consumer loop with dead letter topic
  """
  def start_batched_with_dlq_consumer() do
    PulsarEx.start_consumer(
      "persistent://dlq/consumers/with_dlq",
      "batched-with-dlq-consumer",
      PulsarEx.Demo.Consumers.BatchedWithDLQ,
      []
    )
  end

  def start_dlq_consumer() do
    PulsarEx.start_consumer(
      "persistent://dlq/consumers/dlq",
      "dlq-consumer",
      PulsarEx.Demo.Consumers.DLQ,
      []
    )
  end

  def produce_to_batched_with_dlq_consumer() do
    PulsarEx.produce(
      "persistent://dlq/consumers/with_dlq",
      "test-#{:rand.uniform(1000)}"
    )

    :ok
  end
end
