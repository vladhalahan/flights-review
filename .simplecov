# frozen_string_literal: true

# Exclude folders/files
SimpleCov.add_filter %w[app/channels app/jobs app/mailers app/controllers/pages_controller.rb app/controllers/api_controller.rb app/controllers/application_controller.rb lib/tasks/auto_annotate_models.rake]

SimpleCov.enable_coverage(:branch)
