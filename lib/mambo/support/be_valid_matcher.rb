RSpec::Matchers.define :be_valid do
  match(&:valid?)

  failure_message_for_should do |record|
    "expected #{record.class} #{record.to_param} to be valid, but got the following errors:\n#{formatted_errors(record)}"
  end

  def formatted_errors(record)
    record.errors.full_messages.join("\n")
  end
end

