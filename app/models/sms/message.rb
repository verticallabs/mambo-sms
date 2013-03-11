#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Sms
  class Message < ActiveRecord::Base
    # attributes
    attr_accessible(:subscriber_id, :status, :phone_number, :body, :sid, :created_at)

    STATUSES = [:unknown, :received, :sending, :sent, :failed, :read]
    enum_attr(:status, STATUSES, :init => :unknown, :nil => false)

    # validations
    validates(:phone_number,
      :presence => true,
      :length => {:in => 10..12},
      :format => /^\d*$/)
    validates(:body,
      :length => {:maximum => 160})

    # associations
    belongs_to(:subscriber)
    belongs_to(:parent,
      :class_name => "Message")
    has_many(:children,
      :class_name => "Message",
      :foreign_key => :parent_id,
      :dependent => :destroy)

    # instance methods

    #
    def receive_reply(body, sid, created_at = nil)
      children.create(
        :subscriber_id => subscriber_id,
        :phone_number => phone_number,
        :body => body,
        :status => :received,
        :sid => sid,
        :created_at => created_at
      )
    end

    #
    def send_reply(body)
      children.create(
        :subscriber_id => subscriber_id,
        :phone_number => phone_number,
        :body => body,
        :status => :sending
      )
    end

    #
    def save_status(status, sid)
      self.status = status
      self.sid = sid
      save!
    end

    # class methods
    #
    def self.sent
      where{status == :sent.to_s}
    end

    #
    def self.received
      where{status == :received.to_s}
    end

    #
    def self.read
      where{status == :read.to_s}
    end

    #
    def self.received_or_read
      where{status >> [:received.to_s, :read.to_s]}
    end

    #
    def self.first_by_sid(value)
      where{sid == value.to_s}.first
    end

    #
    def self.send_message(phone_number, body)
      create!(
        :phone_number => phone_number,
        :body => body,
        :status => :sending
      )
    end

    #
    def self.receive_message(phone_number, body, sid, created_at = nil)
      create!(
        :phone_number => phone_number,
        :body => body,
        :status => :received,
        :sid => sid,
        :created_at => created_at
      )
    end

    def self.to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |message|
          csv << message.attributes.values_at(*column_names)
        end
      end
    end

  end
end
