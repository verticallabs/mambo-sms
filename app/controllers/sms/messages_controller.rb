module Sms
	class MessagesController < ApplicationController
		respond_to(:html, :json, :xml)

		# list messages
		def index
			page = params[:page]
			per_page = params[:per_page]

			messages = Message.page(:page => page, :per_page => per_page, :order => :created_at)

			respond_with({:data => messages, :total => messages.pager.total})
		end

		# show a message
		def show
			message = Message.get!(params[:id])

			respond_with(message)
		end
	end
end