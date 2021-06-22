class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to new_user_session_path
    end
  end

  def legal
    render_cell(
      page_cell: Page::Cell::Legal,
      header_cell: Page::Header::Cell::Legal,
      layout: 'application'
    )
  end

  def privacy
    render_cell(
      page_cell: Page::Cell::Privacy,
      header_cell: Page::Header::Cell::Privacy,
      layout: 'application'
    )
  end

  def dashboard
    render_cell(
      page_cell: Page::Cell::Dashboard,
      header_cell: Page::Header::Cell::Dashboard
    )
  end
end
