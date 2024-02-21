class CookieController < ApplicationController
  def show
    assign_cookies_from_params
    render json: cookies_data
  end

  private

  def assign_cookies_from_params
    params.fetch(:cookies, {}).each do |key, value|
      cookies[key] = value
    end
    params.fetch(:encrypted, {}).each do |key, value|
      cookies.encrypted[key] = value
    end
    params.fetch(:permanent, {}).each do |key, value|
      cookies.permanent[key] = value
    end
    params.fetch(:signed, {}).each do |key, value|
      cookies.signed[key] = value
    end
    params.fetch(:signed_and_encrypted, {}).each do |key, value|
      cookies.signed.encrypted[key] = value
    end
  end

  def cookies_data
    {
      cookie: serialize(cookies),
      encrypted: serialize(cookies.encrypted),
      permanent: serialize(cookies.permanent),
      signed: serialize(cookies.signed)
    }
  end

  def serialize(jar)
    cookies.each_with_object({}) do |(key, _), memo|
      memo[key] = jar[key]
    end.compact
  end
end
