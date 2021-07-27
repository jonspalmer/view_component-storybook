# frozen_string_literal: true

module ViewComponentStorybook
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc "Installs storybook"

      def install
        insert_into_file '.gitignore', '*/*.stories.json'
        add_yarn_dependencies
        setup_storybook 
      end


      private

      def add_yarn_dependencies
        run 'yarn add @storybook/server @storybook/addon-controls --dev'
      end

      def setup_storybook
        run 'npx sb init -t server'
      end
    end
  end
end
