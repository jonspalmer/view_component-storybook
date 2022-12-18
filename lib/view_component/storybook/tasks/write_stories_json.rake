# frozen_string_literal: true

namespace :view_component_storybook do
  desc "Write CSF JSON stories for all Stories"
  task write_stories_json: :environment do
    puts "Writing Stories JSON"
    exceptions = []
    ViewComponent::Storybook::Engine.stories.each do |stories|
      json_path = stories.write_csf_json
      puts "#{stories.name} => #{json_path}"
    rescue StandardError => e
      exceptions << e
    end

    raise StandardError, exceptions.map(&:message).join(", ") if exceptions.present?

    puts "Done"
  end
end
