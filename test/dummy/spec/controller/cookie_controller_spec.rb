require "rails_helper"

RSpec.describe CookieController, type: :controller do
  it "reads plain cookies" do
    get :show, params: { cookies: { coffee: "black" } }
    expect(response).to be_successful
    expect(cookies_jar[:coffee]).to eq("black")
  end
end
