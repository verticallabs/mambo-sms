# This migration comes from sms (originally 20120610164323)
class CreateMessages < ActiveRecord::Migration
  #
  def change
    create_table(:sms_messages) do |t|
    	t.references(:subscriber)
    	t.integer(:status, :null => false)
      t.string(:phone_number, {:null => false, :limit => Sms::PHONE_NUMBER_LENGTH})
      t.string(:body, :limit => Sms::MESSAGE_LENGTH)
      t.string(:sid, :limit => Sms::SID_LENGTH)
      t.timestamps
    end
    add_index(:sms_messages, :status)
    add_index(:sms_messages, :phone_number)
    add_index(:sms_messages, :sid)
  end
end
