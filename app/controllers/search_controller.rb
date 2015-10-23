require "net/http"

class SearchController < ApplicationController
  def search
    # https://api.github.com/search/code?q=describe+repo:gitlabhq/gitlabhq+repo:sharetribe/sharetribe+language:ruby+path:spec+filename:_controller_spec.rb
    url = "https://api.github.com/search/code?q=describe+repo:gitlabhq/gitlabhq+repo:sharetribe/sharetribe+language:ruby+path:spec+filename:_controller_spec.rb"
    resp = Net::HTTP.get(URI.parse(url))
    data = JSON.parse(resp)
    total_count = data["total_count"]
    items = data["items"]

    @repos = []
    items.each do |item|
      name = item["repository"]["full_name"]
      @repos << name unless @repos.include? name 
    end
  end
end
