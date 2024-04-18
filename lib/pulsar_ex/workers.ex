defmodule PulsarEx.Demo.Workers do
  alias PulsarEx.Demo.Workers.Worker

  def start_worker() do
    Worker.start(workers: 5)
  end

  def enqueue_job(dup \\ true) do
    Worker.enqueue(%{"dup" => dup})
  end
end
