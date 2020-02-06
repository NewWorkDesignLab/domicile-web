class Domicile::Builder::CustomizedFormBuilder < ActionView::Helpers::FormBuilder
  def text_field_group(attribute, options = {})
    label = label(attribute, options)
    hint = help_block(attribute, options)
    error = error_block(attribute, options)
    aria = aria_describedby(attribute, hint, error, options)

    opts = options[:input_options] || {}
    opts = opts.merge( required: 'required' ) if options[:required]
    opts = opts.merge( aria: { describedby: "#{aria}" } ) unless aria.blank?
    opts = opts.merge( class: "form-control#{error_class(attribute)}" )
    input = text_field(attribute, opts)

    @template.content_tag :div, class: 'form-group' do
      "#{label}#{input}#{hint}#{error}".html_safe
    end
  end

  def text_field(attribute, options = {})
    super(attribute, options)
  end

  def password_field_group(attribute, options = {})
    options[:input_options].merge! type: 'password'
    text_field_group attribute, options
  end

  def email_field_group(attribute, options = {})
    options[:input_options].merge! type: 'email'
    text_field_group attribute, options
  end

  def checkbox_group(attribute, options = {})
    label = label(attribute, options.merge(class: 'form-check-label'))
    hint = help_block(attribute, options)
    error = error_block(attribute, options)
    aria = aria_describedby(attribute, hint, error, options)

    opts = options[:input_options] || {}
    opts = opts.merge( required: 'required' ) if options[:required]
    opts = opts.merge( aria: { describedby: "#{aria}" } ) unless aria.blank?
    opts = opts.merge( class: "form-check-input#{error_class(attribute)}" )
    checked_value = opts.delete(:checked_value) || '1'
    unchecked_value = opts.delete(:unchecked_value) || '0'
    input = check_box(attribute, opts, checked_value, unchecked_value)

    @template.content_tag :div, class: 'form-group form-check' do
      "#{input}#{label}#{hint}#{error}"
    end
  end

  def check_box(attribute, options = {}, checked_value, unchecked_value)
    super(attribute, options, checked_value, unchecked_value)
  end

  def error_block(attribute, options = {})
    opts = options.delete(:error_options) || {}
    opts = opts.merge(class: 'invalid-feedback')
    opts = opts.merge(id: "#{attribute}_error")
    error = @template.content_tag :small, object.errors.messages[attribute.to_sym].first, opts if object.respond_to?(:errors) && object.errors.key?(attribute.to_sym)
    "#{error}".html_safe
  end

  def error_class(attribute)
    if object.respond_to?(:errors) && object.errors.key?(attribute.to_sym)
      ' is-invalid'
    end
  end

  def help_block(attribute, options = {})
    opts = options.delete(:hint_options) || {}
    opts = opts.merge(class: 'form-text text-muted')
    opts = opts.merge(id: "#{attribute}_hint")
    hint = @template.content_tag :small, options.delete(:hint), opts if options[:hint]
    "#{hint}".html_safe
  end

  def label(attribute, options = {})
    required = @template.content_tag :span, '&nbsp;*'.html_safe, aria: { hidden: 'true' } if options[:label] && options[:required]
    text = options.delete(:label) if options[:label]

    super(attribute, "#{text}#{required}".html_safe, options.delete(:label_options) || {})
  end

  def aria_describedby(attribute, hint, error, options = {})
    aria = [].tap do |out|
      out << "required_hint" if options[:required]
      out << "#{attribute}_hint" unless hint.blank?
      out << "#{attribute}_error" unless error.blank?
    end.join(' ')
    aria
  end

  def submit(label, options = {})
    options = options.merge(class: 'btn btn-primary')
    options = options.merge(type: 'submit')
    @template.button_tag label, options
  end
end