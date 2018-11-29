require "set"

module Logbook::CLI
  class App
    def self.stats(paths, options = {})
      new.stats(paths, options)
    end

    def stats(paths, options)
      return if paths.empty?

      paths.select { |path| File.file?(path) }.each do |path|
        name = File.basename(path)
        contents = File.read(path)

        if page = Logbook::Builder.build(contents)
          tasks = filter_tasks(page.tasks.values, options)
          total_duration = tasks.map { |task| task.time_logged.minutes.to_i }.sum
          next unless total_duration > 0

          puts "#{name}: #{format_duration(total_duration)}"

          if options[:per_task]
            tasks.each do |task|
              task_duration = task.time_logged.minutes.to_i
              next unless task_duration > 0

              tags = task.properties.values.select { |p| p.is_tag? }.map { |t| "#" + t.name }.join(" ")
              puts " " * (name.length + 1) + " #{task.title}: #{format_duration(task_duration)}"
            end
          end
        end
      end
    end

    private
    def filter_tasks(tasks, options)
      tasks.select { |task| match_filters?(task, options) }
    end

    def match_filters?(task, options)
      tags = Set.new(task.properties.values.select(&:is_tag?).map(&:name))
      properties = task.properties.values.reject(&:is_tag?).map { |p| [p.name, p.value] }.to_h

      options[:tag_filters].subset?(tags) && options[:property_filters] <= properties
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
