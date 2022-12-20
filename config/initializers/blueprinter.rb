Blueprinter.configure do |config|
  Oj.optimize_rails
  config.generator = Oj
end
