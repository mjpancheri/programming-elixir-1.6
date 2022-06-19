defmodule Duper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  # /home/marciopancheri/codeminer42/clients/petlove/projects/nofaro/health-backoffice
  # /home/marciopancheri/codeminer42/clients/petlove/projects/porto-pet-top-cat
  # /home/marciopancheri/projects/personal/construction_control
  @impl true
  def start(_type, _args) do
    children = [
      Duper.Results,
      {Duper.PathFinder,
       "/home/marciopancheri/codeminer42/clients/petlove/projects/nofaro/health-backoffice"},
      Duper.WorkerSupervisor,
      {Duper.Gatherer, 5}
    ]

    opts = [strategy: :one_for_all, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
