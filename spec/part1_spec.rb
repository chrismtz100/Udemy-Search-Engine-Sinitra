# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "My application" do
  it "should allow accessing the home page" do
    get '/'
    # Rspec 2.x
    expect(last_response).to be_ok
  end

  it "should give an error if no search term is provided" do
    get '/'
    expect(last_response.body).to eq("Error: No Search Term Provided")
  end

  it "should give an error if empty search term is provided" do
    get '/?term='
    expect(last_response.body).to eq("Error: Search Term Empty")
  end

  it "should restate the search term when a search term is provided" do
    get '/?term=java'
    expect(last_response.body.split(":")[0]).to eq("java")

    get '/?term=python'
    expect(last_response.body.split(":")[0]).to eq("python")

    get '/?term=ruby'
    expect(last_response.body.split(":")[0]).to eq("ruby")
  end


  it "should have the format 'term: ####' like 'java: 2342342' when provided a valid search term" do
    get '/?term=java'
    number = last_response.body.split(" ")[1]
    failed = false

    begin
      Integer(number)
    rescue Exception => e
      failed = true
    end

    expect(failed).to eq(false)
  end

end