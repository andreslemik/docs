class CurrencyInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    field_settings = { data: { autonumeric: { mDec: 2, aSep: ' ', aDec: '.' } } }
    @builder.text_field(attribute_name, input_html_options.merge(field_settings))
  end
end
