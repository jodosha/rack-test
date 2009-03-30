require File.join(File.dirname(__FILE__), "/../../spec_helper")

module Rack
  module Test
    describe "TestCase" do
      it "test truth" do
        true.should eql(true)
      end
    end
  end
end