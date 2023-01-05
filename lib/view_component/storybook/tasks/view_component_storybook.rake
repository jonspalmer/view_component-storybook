# frozen_string_literal: true

namespace :view_component_storybook do
  desc "Write CSF JSON stories for all Stories"
  task write_stories_json: :environment do
    puts "Writing Stories JSON"
    exceptions = []
    ViewComponent::Storybook::Stories.all.each do |stories|
      json_path = stories.write_csf_json
      puts "#{stories.name} => #{json_path}"
    rescue StandardError => e
      exceptions << e
    end

    raise StandardError, exceptions.map(&:message).join(", ") if exceptions.present?

    puts "Done"
  end

  desc "Remove all existing CSF JSON Stories"
  task remove_stories_json: :environment do
    puts "Removing old Stories JSON"
    exceptions = []
    Dir["#{ViewComponent::Storybook.stories_path}/**/*.stories.json"].sort.each do |file|
      puts file
      File.unlink(file)
    rescue StandardError => e
      exceptions << e
    end

    raise StandardError, exceptions.map(&:message).join(", ") if exceptions.present?

    puts "Done"
  end
end
