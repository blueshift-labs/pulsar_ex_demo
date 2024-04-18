defmodule PulsarEx.Demo.Workers.Middlewares.Telemetry do
  @behaviour PulsarEx.Middleware

  alias PulsarEx.JobState

  @impl true
  def call(handler) do
    fn %JobState{
         worker: worker,
         topic: topic,
         subscription: subscription
       } = job_state ->
      metadata = %{worker: worker, topic: topic, subscription: subscription}

      job_state = JobState.assign(job_state, :hello, :world)

      case handler.(job_state) do
        %PulsarEx.JobState{state: :ok} = state ->
          :telemetry.execute(
            [:jobs, :handle, :success],
            %{count: 1},
            metadata
          )

          state

        %PulsarEx.JobState{state: {:ok, _}} = state ->
          :telemetry.execute(
            [:jobs, :handle, :success],
            %{count: 1},
            metadata
          )

          state

        state ->
          :telemetry.execute(
            [:jobs, :handle, :error],
            %{count: 1},
            metadata
          )

          state
      end
    end
  end
end
