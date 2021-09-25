require 'graphql/rake_task'

GraphQL::RakeTask.new(
  schema_name: 'CepSchema',
  directory: './export/graphql',
  dependencies: [:environment],
)
