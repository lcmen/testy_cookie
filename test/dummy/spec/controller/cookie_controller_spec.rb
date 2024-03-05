require "rails_helper"

RSpec.describe CookieController, type: :controller do
  it "reads plain cookie_jar" do
    get :show, params: {cookies: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar[:coffee]).to eq("black")
  end

  it "reads encrypted cookie_jar" do
    get :show, params: {encrypted: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar.encrypted[:coffee]).to eq("black")
  end

  it "reads permanent cookie_jar" do
    get :show, params: {permanent: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar.permanent[:coffee]).to eq("black")
  end

  it "reads signed cookie_jar" do
    get :show, params: {signed: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar.signed[:coffee]).to eq("black")
  end

  it "sets plain cookie_jar" do
    cookie_jar[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("cookie", "coffee")).to eq("black")
  end

  it "sets encrypted cookie_jar" do
    cookie_jar.encrypted[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("encrypted", "coffee")).to eq("black")
  end

  it "sets permanent cookie_jar" do
    cookie_jar.permanent[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("permanent", "coffee")).to eq("black")
  end

  it "sets signed cookie_jar" do
    cookie_jar.signed[:coffee] = "black"
    get :show
    expect(response).to be_successful
    expect(response.parsed_body.dig("signed", "coffee")).to eq("black")
  end

  it "reads and sets combined cookie_jar" do
    cookie_jar.signed.encrypted[:coffee] = "black"

    get :show, params: {signed_and_encrypted: {ice_cream: "vanilla"}}
    expect(response).to be_successful

    expect(cookie_jar.signed.encrypted[:coffee]).to eq("black")
    expect(cookie_jar.signed.encrypted[:ice_cream]).to eq("vanilla")
  end
end
