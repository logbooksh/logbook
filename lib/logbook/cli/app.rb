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
          total_duration = page.logged_time.minutes.to_i
          next unless total_duration > 0

          puts "#{name}: #{format_duration(total_duration)}"

          if options[:per_task]
            page.tasks.each do |_, task|
              task_duration = task.time_logged.minutes.to_i
              next unless task_duration > 0

              puts " " * (name.length + 1) + " #{task.title}: #{format_duration(task_duration)}"
            end
          end
        end
      end
    end

    private
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
