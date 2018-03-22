defmodule Mix.Tasks.Start do
  use Mix.Task

  def run(_) do
    # calling our Hello.say() function from earlier
    TextClient.start()
  end
end
