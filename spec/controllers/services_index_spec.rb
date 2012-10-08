require 'spec_helper'

target = [ ServicesController, "#index" ]

describe *target, 'normal case' do
  before(:all) do
    get("/services")
  end

  it { status_code.should == 200 }
end

