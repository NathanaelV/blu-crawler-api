class CrawlerController < ApplicationController
  def activate
    CreateSuppliersJob.perform_later
    redirect_to crawler_running_path
  end

  def crawler_running
  end
end
