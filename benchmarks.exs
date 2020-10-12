Application.ensure_all_started(:weirding)

Benchee.run(
  %{
    "generate" => fn input -> Weirding.words(input) end,
  },
  inputs: %{
    "small" => 40,
    "medium" => 200,
    "large" => 500,
  }
)
