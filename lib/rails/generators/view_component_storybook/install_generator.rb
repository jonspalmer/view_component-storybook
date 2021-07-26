# frozen_string_literal: true

module ViewComponentStorybook
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      desc "Installs storybook"

      def install
        insert_into_file '.gitignore', '*/*.stories.json'
        add_yarn_dependencies
        generate_storybook_files
      end


      private

      def add_yarn_dependencies
        run 'yarn add @storybook/server @storybook/addon-controls --dev'
      end

      def generate_storybook_files
        template 'main.js.tt', '.storybook/main.js'
        template 'preview.js.tt', '.storybook/preview.js'
      end
    end
  end
end
