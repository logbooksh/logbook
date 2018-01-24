module Logbook::CLI
  class App
    def self.stats(options)
      puts "Hello #{options["per-task"]}"
    end
  end
end
