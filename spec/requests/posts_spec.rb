require './spec/spec_helper'
describe PostsControllers do

  def app
    @app ||= PostsControllers.new
  end

  describe "GET '/unknown'" do

    it "returns a 404 response for unknown requests" do
      get '/unknown'
      last_response.status.should be(404)
    end

  end

end