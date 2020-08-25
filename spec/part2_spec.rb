# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "My application" do
 
  it "should have the format 'term: ####' like 'java: 2342342' when provided a valid search term and get the count using get_search_count" do
    terms = ["java", "python", "ruby", "javascript"]

    terms.each do |term|
      get "/?term=#{term}"
      count = get_search_count(term)

      expect(last_response.body).to eq("#{term}: #{count}")
    end
  end

end

describe "get_search_count method" do
  it "should return an integer" do
    expect(get_search_count("java")).to be_a_kind_of(Fixnum)
  end

  it "should get value from internet" do
      class Cheater
        attr_accessor :h_i, :j_p, :i_v
      end

      $c = Cheater.new

      class Net::HTTP
        def self.get(uri_or_host, path = nil, port = nil)
          $c.h_i = true
          get_response(uri_or_host, path, port).body
        end
      end

      module JSON
        def self.parse(source, opts = {})
          $c.j_p = true
          r = Parser.new(source, opts).parse
          $c.i_v = r["results"][0]["searched_count"]
          return r
        end
      end

      search_count = get_search_count("java")
      expect($c.h_i).to eq(true), "expected you to hit the internet...."
      expect($c.j_p).to eq(true), "expected you to parse json...."
      expect(search_count).to eq($c.i_v), "expected what you returned to be what you got from the internet"
  end

end