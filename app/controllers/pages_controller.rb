class PagesController < ApplicationController
  def index
    # render plain: user_signed_in?.to_s
    render_cell(
      page_cell: Page::Cell::Index,
      header_cell: Page::Header::Cell::Index
    )
  end
end