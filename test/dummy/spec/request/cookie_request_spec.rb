# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /cookie", type: :request do
  it "reads plain cookie_jar" do
    get "/cookie", params: {cookies: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar[:coffee]).to eq("black")
  end

  it "reads encrypted cookie_jar" do
    get "/cookie", params: {encrypted: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar.encrypted[:coffee]).to eq("black")
  end

  it "reads permanent cookie_jar" do
    get "/cookie", params: {permanent: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar.permanent[:coffee]).to eq("black")
  end

  it "reads signed cookie_jar" do
    get "/cookie", params: {signed: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookie_jar.signed[:coffee]).to eq("black")
  end

  it "sets plain cookie_jar" do
    cookie_jar[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("cookie", "coffee")).to eq("black")
  end

  it "sets encrypted cookie_jar" do
    cookie_jar.encrypted[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("encrypted", "coffee")).to eq("black")
  end

  it "sets permanent cookie_jar" do
    cookie_jar.permanent[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("permanent", "coffee")).to eq("black")
  end

  it "sets signed cookie_jar" do
    cookie_jar.signed[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("signed", "coffee")).to eq("black")
  end

  it "reads and sets cookie_jar on multiple requests" do
    cookie_jar[:coffee] = "black"
    cookie_jar.encrypted[:additive] = "sugar"
    cookie_jar.permanent[:milk] = "soy"

    get "/cookie", params: {cookies: {sandwich: "tuna"}, signed: {fruit: "apple"}, permanent: {juice: "orange"}}
    expect(response).to be_successful

    expect(cookie_jar[:coffee]).to eq("black")
    expect(cookie_jar[:sandwich]).to eq("tuna")
    expect(cookie_jar.encrypted[:additive]).to eq("sugar")
    expect(cookie_jar.permanent[:milk]).to eq("soy")
    expect(cookie_jar.permanent[:juice]).to eq("orange")
    expect(cookie_jar.signed[:fruit]).to eq("apple")

    get "/cookie", params: {encrypted: {cake: "chocolate"}, permanent: {ice_cream: "vanilla"}}

    expect(cookie_jar[:coffee]).to eq("black")
    expect(cookie_jar[:sandwich]).to eq("tuna")
    expect(cookie_jar.encrypted[:additive]).to eq("sugar")
    expect(cookie_jar.encrypted[:cake]).to eq("chocolate")
    expect(cookie_jar.permanent[:milk]).to eq("soy")
    expect(cookie_jar.permanent[:ice_cream]).to eq("vanilla")
    expect(cookie_jar.permanent[:juice]).to eq("orange")
    expect(cookie_jar.signed[:fruit]).to eq("apple")
  end

  it "reads and sets combined cookie_jar" do
    cookie_jar.signed.encrypted[:coffee] = "black"

    get "/cookie", params: {signed_and_encrypted: {ice_cream: "vanilla"}}
    expect(response).to be_successful

    expect(cookie_jar.signed.encrypted[:coffee]).to eq("black")
    expect(cookie_jar.signed.encrypted[:ice_cream]).to eq("vanilla")
  end
end
