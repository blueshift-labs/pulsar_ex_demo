defmodule PulsarEx.Demo.Workers.Interceptors.Dedup do
  @behaviour PulsarEx.Interceptor

  alias PulsarEx.JobInfo

  require Logger

  @impl true
  def call(handler) do
    fn %JobInfo{params: %{"dup" => dup}} = job_info ->
      if dup do
        %{job_info | state: {:ok, :duplicated}}
      else
        handler.(job_info)
      end
    end
  end
end
