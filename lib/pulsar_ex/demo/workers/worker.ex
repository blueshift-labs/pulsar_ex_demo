defmodule PulsarEx.Demo.Workers.Worker do
  use PulsarEx.Worker,
    otp_app: :pulsar_ex_demo,
    topic: "persistent://demo/workers/demo",
    subscription: "demo.workers",
    subscription_type: :shared,
    interceptors: [
      PulsarEx.Demo.Workers.Interceptors.Dedup
    ],
    middlewares: [
      PulsarEx.Demo.Workers.Middlewares.Telemetry
    ],
    max_redelivery_attempts: 3,
    dead_letter_topic: "persistent://demo/workers/demo_dlq",
    producer_opts: [num_producers: 3]

  require Logger

  @impl PulsarEx.WorkerCallback
  def handle_job(%{assigns: assigns, payload: payload}) do
    Logger.info("Processing job payload #{inspect(payload)} with assigns #{inspect(assigns)}")

    :ok
  end
end
