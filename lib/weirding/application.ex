defmodule Weirding.Application do
  @moduledoc false
  use Application

  def start(_, _) do
    children = [
      Weirding.Chain,
    ]

    opts = [strategy: :one_for_one, name: Weirding.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
