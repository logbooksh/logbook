require "spec_helper"

RSpec.describe Logbook do
  it "has a version number" do
    expect(Logbook::CLI::VERSION).not_to be nil
  end
end
