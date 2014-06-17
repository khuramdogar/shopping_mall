require 'rails/generators/base'

module ShoppingMall
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      class_option :auto_run_migrations, :type => :boolean, :default => false

      desc 'Creates initializer and inserts middleware'

      def copy_initializer
        template 'shopping_mall.rb', 'config/initializers/shopping_mall.rb'
      end

      def copy_middleware
        application do
          <<-STR

    # Inserted with shopping_mall:install
    config.middleware.insert_before(
      'ActiveRecord::ConnectionAdapters::ConnectionManagement',
      'ShoppingMall::Escalator'
    )
          STR
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=shopping_mall'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
