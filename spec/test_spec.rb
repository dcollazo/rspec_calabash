require_relative 'spec_helper'

describe "login" do
  before do
    touch query("button marked:'Login'")
  end
  
  context "wrong credentials" do
    error_message = query("label marked:'error'")
    let(error_message) { size > 0 }
  end
end