#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Sms
	class MessageTemplatesController < BaseController
		include ::Authentication::AuthenticatedController
		respond_to(:html)
		layout("layouts/private/sms")

    before_filter(:only => :index) do
    	page_param(:message_templates)
      sort_param(:message_templates, :name, :asc)
    end

		#
		def index
			@message_templates = MessageTemplate.sorted_by(@sort_key, @sort_order).paginate(:page => @page, :per_page => 20)
			respond_with(@message_templates)
		end

		#
		def new
			@message_template = MessageTemplate.new
			respond_with(@message_template)
		end

		#
		def create
			begin
				message_template = params[:message_template]
				@message_template = MessageTemplate.create_by(message_template)
				flash[:notice] = t(:created)
				respond_with(@message_template, :location => message_templates_path)

			rescue ActiveRecord::RecordInvalid => error
				@message_template = error.resource
				respond_with(@message_template) do |format|
					format.html {	render(:new) }
				end
			end
		end

		#
		def edit
			@message_template = MessageTemplate.find(params[:id])
			respond_with(@message_template)
		end

		#
		def update
			begin
				message_template = params[:message_template]
				@message_template = MessageTemplate.update_by_id(params[:id], message_template)
				flash[:notice] = t(:updated)
				respond_with(@message_template, :location => message_templates_path)

			rescue ActiveRecord::RecordInvalid => error
				@message_template = error.resource
				respond_with(@message_template) do |format|
					format.html {	render(:edit) }
				end
			end
		end

		#
		def destroy
			@message_template = MessageTemplate.destroy_by_id(params[:id])
			flash[:notice] = t(:destroyed)
			respond_with(@message_template, :location => message_templates_path)
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:sms, :message_templates])
		end
	end
end
