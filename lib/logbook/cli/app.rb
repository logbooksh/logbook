require "set"

module Logbook::CLI
  class App
    MIN_COLUMN_SIZE = 4

    def self.tasks(paths, options = {})
      new.tasks(paths, options)
    end

    def tasks(paths, options)
      default_options = {tags: []}
      options = default_options.merge(options)

      if options[:status]
        options[:status] =
          case options[:status]
          when "todo"
            Logbook::Task::Status::TODO
          when "ongoing"
            Logbook::Task::Status::ONGOING
          when "done"
            Logbook::Task::Status::DONE
          else
            puts "Warning: unknown task status #{options[:status]}"
          end
      end

      pages_by_file = parse_files(paths)
      warn_about_parsing_errors(pages_by_file)

      tasks_by_file = pages_by_file.reject { |_, page| page.nil? }.map do |file_name, page|
        tasks = page.tasks.select { |task| options[:tags].subset?(task.tags) }
        tasks = tasks.select { |task| task.status == options[:status] } if options[:status]
        tasks = tasks.select { |task| (options[:has_property] - task.properties.keys).empty? }
        tasks = tasks.select { |task| options[:properties] <= task.properties }

        [file_name, tasks]
      end.select { |_, tasks| tasks.any? }.to_h

      max_file_name_length = tasks_by_file.keys.map(&:length).max || 0
      max_task_title_length = tasks_by_file.values.flatten.map(&:title).map(&:length).max || 0
      file_name_col_length = [MIN_COLUMN_SIZE, max_file_name_length].max
      task_title_col_length = [MIN_COLUMN_SIZE, max_task_title_length].max

      puts "FILE" + " " * (file_name_col_length - 4 + 4) +
        "TASK" + " " * (task_title_col_length - 4 + 4) +
        "TIME LOGGED"

      tasks_by_file.each do |file_name, tasks|
        tasks.each do |task|
          puts file_name + " " * (file_name_col_length - file_name.length + 4) +
            task.title + " " * (task_title_col_length - task.title.length + 4) +
            format_duration(task.logged_time.minutes.to_i)
        end
      end
    end

    private
    def parse_files(paths)
      paths.select { |path| File.file?(path) }.map do |path|
        name = File.basename(path)
        contents = File.read(path)
        [name, Logbook::Builder.build(contents)]
      end.to_h
    end

    def warn_about_parsing_errors(pages_by_file)
      pages_by_file.select { |file_name, page| page.nil? }.each do |file_name, page|
        puts "Could not parse #{file_name}. Skipping..."
      end
    end

    def format_duration(duration)
      hours = duration / 60
      minutes = duration % 60

      if duration == 0
        "0"
      elsif minutes == 0
        "#{hours}h"
      elsif hours == 0
        "#{minutes} min"
      else
        "#{hours} h #{minutes} min"
      end
    end
  end
end
