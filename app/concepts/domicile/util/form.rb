module Domicile::Util::Form
  def input_group(attribute, model, **options)
    label = label_tag attribute, options.delete(:label) if options[:label]
    hint = content_tag :small, options[:hint], class: 'form-text text-muted', id: "#{attribute}_hint" if options[:hint]
    aria = [].tap do |out|
      out << "#{attribute}_hint" if options[:hint]
      out << "#{attribute}_error" if errors(attribute, model)
    end.join(' ')

    opts = options[:input_options] || {}
    opts = opts.merge( aria: { describedby: "#{aria}" } ) unless aria.blank?
    opts = opts.merge( class: 'form-control' )
    input = yield(opts)

    content_tag :div, class: "form-group#{error_class(attribute, model)}" do
      "#{label}#{input}#{hint}#{errors(attribute, model)}".html_safe
    end
  end

  def text_field_group(attribute, model, **options)
    input_group(attribute, model, options) do |opts|
      text_field_tag(attribute, options.delete(:value), opts)
    end
  end

  def passwort_field_group(attribute, model, **options)
    input_group(attribute, model, options) do |opts|
      password_field_tag(attribute, nil, opts)
    end
  end

  def email_field_group(attribute, model, **options)
    input_group(attribute, model, options) do |opts|
      email_field_tag(attribute, options.delete(:value), opts)
    end
  end

  def checkbox_group(attribute, model, **options)
    label = label_tag attribute, options.delete(:label), class: 'form-check-label' if options[:label]
    hint = content_tag :small, options[:hint], class: 'form-text text-muted', id: "#{attribute}_hint" if options[:hint]
    aria = [].tap do |out|
      out << "#{attribute}_hint" if options[:hint]
      out << "#{attribute}_error" if errors(attribute, model)
    end.join(' ')

    opts = options[:input_options] || {}
    opts = opts.merge( aria: { describedby: "#{aria}" } ) unless aria.blank?
    opts = opts.merge( class: "form-check-input#{error_class(attribute, model)}" )

    input = check_box_tag(attribute, options[:value] || '1', options[:checked] || false, opts)
    content_tag :div, class: 'form-group form-check' do
      "#{input}#{label}#{hint}#{errors(attribute, model)}"
    end
  end

  def errors(attribute, model)
    if model.respond_to?(:errors) && model.errors.key?(attribute.to_sym)
      content_tag :small, model.errors.messages[attribute.to_sym].first, class: 'invalid-feedback', id: "#{attribute}_error"
    end
  end

  def error_class(attribute, model)
    if model.respond_to?(:errors) && model.errors.key?(attribute.to_sym)
      ' in_invalid'
    end
  end

  def submit_button(label, **options)
    content_tag :button, label, class: 'btn btn-primary'
  end
end