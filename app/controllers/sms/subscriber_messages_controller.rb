module Sms
	class SubscriberMessagesController < ApplicationController
		respond_to(:html)

		# list messages for subscriber
		def index
			@page = params[:page]

			@subscriber = Subscriber.get!(params[:subscriber_id])

			@messages = @subscriber.subscriber.messages.search(@page, 6)

			respond_with(@subscriber, @messages)
		end

		# new message form for subscriber
		def new
			@subscriber = Subscriber.get!(params[:subscriber_id])

			@message = @subscriber.subscriber.messages.new

			respond_with(@subscriber, @message)
		end

		# create a new message for subscriber
		def create
			begin
				@subscriber = Subscriber.get!(params[:subscriber_id])

				if params[:message][:body].empty?
					body = t(params[:message_body])
				else
					body = params[:message][:body]
				end

				@message = Message.create_to_subscriber(@subscriber.subscriber, body)


				flash[:notice] = t(:message_created)

				respond_with(@message, :location => admin_weltel_subscriber_messages_path(@subscriber))

			rescue DataMapper::SaveFailureError => error
				@message = error.resource

				respond_with(@message) do |format|
					format.html { render(:new) }
				end
			end
		end
	end
end