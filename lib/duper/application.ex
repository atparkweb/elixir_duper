defmodule Duper.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Duper.Results,
      { Duper.PathFinder, "." },
      Duper.WorkerSupervisor,
      { Duper.Gatherer, 1 }
    ]

    # If any of the above children fails that means the whole
    # application should fail, so :one_for_all is used
    opts = [strategy: :one_for_all, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
