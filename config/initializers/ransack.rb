Ransack.configure do |config|
  config.add_predicate 'date_equals',
    arel_predicate: 'eq',
    formatter: proc { |v| v.to_date.to_s(:db) },
    validator: proc { |v| v.present? },
    compounds: true,
    type: :date
end
