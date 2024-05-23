# frozen_string_literal: true

# Suggested docs
# --------------
# http://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md
# https://github.com/thoughtbot/factory_bot/wiki/Example-factories.rb-file
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    # Test factories in spec/factories are working.
    # puts 'FactoryBot is linting know factories...'
    # FactoryBot.lint
    # puts 'All FactoryBot factories are valid!'
    # # You can lint factories selectively by passing only
    # # factories you want linted:
    # factories_to_lint = FactoryBot.factories.reject do |factory|
    #   factory.name =~ /^old_/
    # end

    # FactoryBot.lint factories_to_lint
    # # This would lint all factories that aren't prefixed with old_.
  end
end
