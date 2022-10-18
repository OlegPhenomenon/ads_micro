require 'ougai'

Application.configure do |app|
  logger = Ougai::Logger.new(
    app.root.concat('/', Settings.logger.path),
    level: Settings.logger.level
  )

  logger.formatter = Ougai::Formatters::Readable.new if ENV['RACK_ENV'] == 'development'

  logger.before_log = lambda do |data|
    data[:service] = { name: Settings.app.name }
    data[:request_id] ||= Thread.current[:request_id]
  end

  app.set :logger, logger
end

Sequel::Model.db.loggers.push(Application.logger)

logger = Ougai::Logger.new(
  Application.root.concat('/', Settings.logger.path),
  level: Settings.logger.level
)

logger.before_log = lambda do |data|
  data[:service] = { name: Settings.app.name }
  data[:request_id] ||= Thread.current[:request_id]
end

Application.logger = logger
