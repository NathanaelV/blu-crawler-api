class CrawlerController < ApplicationController
  def activate
    CrawlerCategoriesJob.perform_now
  end
end
