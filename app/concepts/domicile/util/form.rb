module Domicile::Util::Form
  include ActionView::Context

  def customized_form_for(record, options = {}, &block)
    html_options = options[:html] || {}
    html_options[:novalidate] = true

    options.merge!(builder: Domicile::Builder::CustomizedFormBuilder, html: html_options)
    form_for(record, options) do |f|
      block.call(f).html_safe
    end
  end

  def form_required_hint
    content_tag :small, "<span aria-hidden='true'>*&nbsp;</span>Dieses Feld ist ein Pflichtfeld".html_safe, class: 'text-muted', id: 'required_hint'
  end
end
