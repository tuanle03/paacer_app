Rails.application.config.to_prepare do
  # Load all decorator files manually
  Dir.glob(Rails.root.join('app/decorators/**/*_decorator.rb')).each do |decorator|
    require_dependency decorator
  end
end
