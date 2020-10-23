class DashboardController < ApplicationController
  def index
    @books = current_user.books.includes(:comments)
  end
end
