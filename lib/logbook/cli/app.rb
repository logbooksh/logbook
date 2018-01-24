module Logbook::CLI
  class App
    def self.stats(paths)
      return if paths.empty?

      paths.select { |path| File.file?(path) }.each do |path|
        name = File.basename(path)
        contents = File.read(path)

        if page = Logbook::Builder.build(contents)
          duration = page.total_duration.minutes.to_i

          hours = duration / 60
          minutes = duration % 60

          puts "#{name}: #{hours}h#{minutes}min"
        end
      end
    end
  end
end
