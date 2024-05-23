# frozen_string_literal: true

require 'rake'

# Task names should be used in the top-level describe, with an optional
# "rake "-prefix for better documentation. Both of these will work:
#
# 1) describe "foo:bar" do ... end
#
# 2) describe "rake foo:bar" do ... end
#
# Including "rake "-prefix makes it clear a rake task is under test and
# how it is used.
module TaskFormat
  extend ActiveSupport::Concern
  included do
    let(:task_name) { self.class.top_level_description.delete_prefix('rake ') }
    let(:tasks) { Rake::Task }
    # Make the rake task being tested available as "task"
    subject(:task) { tasks[task_name] }
    # Use "run_task" when needing to run the task multiple times in a spec.
    let :run_task do
      task.reenable
      task.invoke
    end
  end
end

RSpec.configure do |config|
  # Tag rake specs with `:task` metadata or put them in the spec/tasks dir
  config.define_derived_metadata(file_path: %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end
  config.include TaskFormat, type: :task

  config.before(:suite) do
    Rails.application.load_tasks
  end
end
