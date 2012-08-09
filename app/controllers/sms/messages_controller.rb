#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Sms
	class MessagesController < BaseController
		include ::Authentication::AuthenticatedController
		respond_to(:html, :json, :xml)

		# list messages
		def index
			page = params[:page]
			per_page = params[:per_page]
			@messages = Message.page(:page => page, :per_page => per_page, :order => :created_at)
			respond_with({:data => @messages, :total => @messages.pager.total})
		end

		# show a message
		def show
			@message = Message.get!(params[:id])
			respond_with(@message)
		end
	end
end
