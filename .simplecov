# frozen_string_literal: true

SimpleCov.add_group('Policies', 'app/policies')

# Exclude folders/files
SimpleCov.add_filter %w[app/channels app/jobs app/mailers app/controllers lib/tasks/auto_annotate_models.rake]

SimpleCov.enable_coverage(:branch)
