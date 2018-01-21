require "spec_helper"

RSpec.describe Logbook do
  it "has a version number" do
    expect(Logbook::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
