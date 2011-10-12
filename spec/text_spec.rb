require 'spec_helper'

describe Text do

  describe "linkify" do
    it "replaces an url in a string with a link" do
      linkify("hi http://google.com ho").should eql("hi <a href=\"http://google.com\">http://google.com</a> ho")
    end

    it "replaces an url without protocol in a string with a link" do
      linkify("hi www.google.com ho").should eql("hi <a href=\"http://www.google.com\">www.google.com</a> ho")
    end

    it "replaces nothing in a string without a url" do
      linkify("hi google ho").should eql("hi google ho")
    end
  end
  
  describe "simple_format" do
    
  end
  
  describe "nl2br" do
    it "adds br tags after new lines" do
      text = "This\nis a\ntest\n"      
      nl2br(text).should eql("This\n<br />is a\n<br />test\n")      
    end
  end  

end