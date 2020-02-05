module ApplicationHelper
  def html_head
    header_cell = @html_head || Page::Header::Cell::Index
    cell(header_cell).()
  end
end
