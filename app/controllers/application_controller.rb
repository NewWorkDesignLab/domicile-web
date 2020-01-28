class ApplicationController < ActionController::Base
  include Domicile::CookieHelpers

  def render_cell(page_cell:, header_cell:, cell_object: nil, layout: 'application', status: :ok, **options)
    @html_head = header_cell
    render(html: cell(page_cell, cell_object, options).(), layout: layout, status: status)
  end
end
