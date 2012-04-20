module Sms
	class MessageTemplatesController < BaseController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("layouts/private/sms")

		#
		def index
			@page = params[:page]
			@message_templates = MessageTemplate.all.page(:page => @page, :per_page => 6, :order => :id)
		end

		#
		def new
			@message_template = MessageTemplate.new
		end

		#
		def create
			begin
				@message_template = MessageTemplate.create_by(params[:message_template])
				flash[:notice] = t(:created)
				respond_with(@message_template, :location => message_templates_path)

			rescue DataMapper::SaveFailureError => error
				@message_template = error.resource
				respond_with(@message_template) do |format|
					format.html {	render(:new) }
				end
			end
		end

		#
		def edit
			@message_template = MessageTemplate.get!(params[:id])
		end

		#
		def update
			begin
				@message_template = MessageTemplate.update_by_id(params[:id], params[:message_template])
				flash[:notice] = t(:updated)
				respond_with(@message_template, :location => message_templates_path)

			rescue DataMapper::SaveFailureError => error
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
