require "rails_helper"

RSpec.describe CookieController, type: :controller do
  it "reads plain cookies_jar" do
    get :show, params: { cookies: { coffee: "black" } }
    expect(response).to be_successful
    expect(cookies_jar[:coffee]).to eq("black")
  end

  it "reads encrypted cookies_jar" do
    get :show, params: { encrypted: { coffee: "black" } }
    expect(response).to be_successful
    expect(cookies_jar.encrypted[:coffee]).to eq("black")
  end

  it "reads permanent cookies_jar" do
    get :show, params: { permanent: { coffee: "black" } }
    expect(response).to be_successful
    expect(cookies_jar.permanent[:coffee]).to eq("black")
  end

  it "reads signed cookies_jar" do
    get :show, params: { signed: { coffee: "black" } }
    expect(response).to be_successful
    expect(cookies_jar.signed[:coffee]).to eq("black")
  end

  it "sets plain cookies_jar" do
    cookies_jar[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("cookie", "coffee")).to eq("black")
  end

  it "sets encrypted cookies_jar" do
    cookies_jar.encrypted[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("encrypted", "coffee")).to eq("black")
  end

  it "sets permanent cookies_jar" do
    cookies_jar.permanent[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("permanent", "coffee")).to eq("black")
  end

  it "sets signed cookies_jar" do
    cookies_jar.signed[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("signed", "coffee")).to eq("black")
  end
end
