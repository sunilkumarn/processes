
require 'spec_helper'

describe ProcessesController do

  let(:process_id_list) { "PID\n2523\n29394\n93838\n"  }

  describe "GET 'list'" do
    it "returns http success" do
      get 'list'
      response.should be_success
    end

    it "returns a json response which contains the pids of processes" do
      controller.stub(:`).and_return(process_id_list)
      get 'list'
      expected_response = ["2523","29394","93838"]
      JSON.parse(response.body).should eql expected_response
      response.header['Content-Type'].should include 'application/json'
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => '2914'
      response.should be_success
    end

    it "returns a json response" do
      get 'show', :id => '2914'
      response.header['Content-Type'].should include 'application/json'
    end

    it "returns an error status if the process does not exist" do
      controller.stub(:`).and_return("")
      get 'show', :id => '2914'
      expected_response = {'status' => 'error', 'reason' => 'No such process running at present!'}
      JSON.parse(response.body).should eql expected_response
    end

    it "returns the details of the process if the process exists" do
      controller.stub(:`).and_return("2941 29.0 29.8 00:22:40 java\n")
      get 'show', :id => '2914'
      expected_response = {"pid" => "2941","pcpu" => "29.0","pmem" => "29.8","time" => "00:22:40","comm" => "java"}
      JSON.parse(response.body).should eql expected_response
    end

  end
end