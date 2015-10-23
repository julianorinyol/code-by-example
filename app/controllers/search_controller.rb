require "net/http"

class SearchController < ApplicationController
  def search
    # https://api.github.com/search/code?q=describe+repo:gitlabhq/gitlabhq+repo:sharetribe/sharetribe+language:ruby+path:spec+filename:_controller_spec.rb
    urls = [
      {url:"https://api.github.com/search/code?q=describe+repo:gitlabhq/gitlabhq+repo:sharetribe/sharetribe+language:ruby+path:spec+filename:_controller_spec.rb", path: "/tree/master/spec/controllers"},
      {url:"https://api.github.com/search/code?q=factory+repo:gitlabhq/gitlabhq+repo:sharetribe/sharetribe+language:ruby+path:spec+filename:factories.rb", path: "/spec/factories.rb"}
    ]
    index = params[:q].to_i
    resp = Net::HTTP.get(URI.parse(urls[index][:url]))
    data = JSON.parse(resp)
    total_count = data["total_count"]
    items = data["items"]

    @repos = []
    items.each do |item|
      path = "http://github.com/" + item["repository"]["full_name"] + urls[index][:path]
      @repos << path unless @repos.include? path 
    end
  end
end

# 1 github.com/githubq/githubq/spec/controllers
# 2 github.com/githubq/githubq/spec/factories.rb