# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /cookie", type: :request do
  it "reads plain cookies_jar" do
    get "/cookie", params: {cookies: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookies_jar[:coffee]).to eq("black")
  end

  it "reads encrypted cookies_jar" do
    get "/cookie", params: {encrypted: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookies_jar.encrypted[:coffee]).to eq("black")
  end

  it "reads permanent cookies_jar" do
    get "/cookie", params: {permanent: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookies_jar.permanent[:coffee]).to eq("black")
  end

  it "reads signed cookies_jar" do
    get "/cookie", params: {signed: {coffee: "black"}}
    expect(response).to be_successful
    expect(cookies_jar.signed[:coffee]).to eq("black")
  end

  it "sets plain cookies_jar" do
    cookies_jar[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("cookie", "coffee")).to eq("black")
  end

  it "sets encrypted cookies_jar" do
    cookies_jar.encrypted[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("encrypted", "coffee")).to eq("black")
  end

  it "sets permanent cookies_jar" do
    cookies_jar.permanent[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("permanent", "coffee")).to eq("black")
  end

  it "sets signed cookies_jar" do
    cookies_jar.signed[:coffee] = "black"
    get "/cookie"
    expect(response).to be_successful
    expect(response.parsed_body.dig("signed", "coffee")).to eq("black")
  end

  it "reads and sets cookies_jar on multiple requests" do
    cookies_jar[:coffee] = "black"
    cookies_jar.encrypted[:additive] = "sugar"
    cookies_jar.permanent[:milk] = "soy"

    get "/cookie", params: {cookies: {sandwich: "tuna"}, signed: {fruit: "apple"}, permanent: {juice: "orange"}}
    expect(response).to be_successful

    expect(cookies_jar[:coffee]).to eq("black")
    expect(cookies_jar[:sandwich]).to eq("tuna")
    expect(cookies_jar.encrypted[:additive]).to eq("sugar")
    expect(cookies_jar.permanent[:milk]).to eq("soy")
    expect(cookies_jar.permanent[:juice]).to eq("orange")
    expect(cookies_jar.signed[:fruit]).to eq("apple")

    get "/cookie", params: {encrypted: {cake: "chocolate"}, permanent: {ice_cream: "vanilla"}}

    expect(cookies_jar[:coffee]).to eq("black")
    expect(cookies_jar[:sandwich]).to eq("tuna")
    expect(cookies_jar.encrypted[:additive]).to eq("sugar")
    expect(cookies_jar.encrypted[:cake]).to eq("chocolate")
    expect(cookies_jar.permanent[:milk]).to eq("soy")
    expect(cookies_jar.permanent[:ice_cream]).to eq("vanilla")
    expect(cookies_jar.permanent[:juice]).to eq("orange")
    expect(cookies_jar.signed[:fruit]).to eq("apple")
  end

  it "reads and sets combined cookies_jar" do
    cookies_jar.signed.encrypted[:coffee] = "black"

    get "/cookie", params: {signed_and_encrypted: {ice_cream: "vanilla"}}
    expect(response).to be_successful

    expect(cookies_jar.signed.encrypted[:coffee]).to eq("black")
    expect(cookies_jar.signed.encrypted[:ice_cream]).to eq("vanilla")
  end
end
