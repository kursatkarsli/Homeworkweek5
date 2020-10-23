class WelcomeController < ApplicationController
  def index
    if current_user.present?
      redirect_to dashboard_index_path
    else
      @books = Book.where(status: true)
    end
  end
end
