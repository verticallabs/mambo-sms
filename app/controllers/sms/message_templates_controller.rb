#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Sms
	class MessageTemplatesController < BaseController
		include ::Authentication::AuthenticatedController
		respond_to(:html)
		layout("layouts/private/sms")

    before_filter(:only => :index) do
    	page_param(:message_templates, 20)
      sort_param(:message_templates, :name, :asc)
    end

		#
		def index
			@message_templates = MessageTemplate
				.sorted_by(@sort_attribute, @sort_order)
				.paginate(:page => @page, :per_page => @per_page)
			# respond_with(@message_templates)
			respond_to do |format|
				format.html { @message_templates }
      	format.csv  { send_data MessageTemplate.to_csv }
			end
		end

		#
		def new
			@message_template = MessageTemplate.new
			respond_with(@message_template)
		end

		#
		def create
			begin
				MessageTemplate.transaction do
					message_template = params[:message_template]
					@message_template = MessageTemplate.create!(message_template)
					flash[:notice] = t(:created)
					respond_with(@message_template, :location => message_templates_path)
				end

			rescue ActiveRecord::RecordInvalid => error
				@message_template = error.record
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
				MessageTemplate.transaction do
					message_template = params[:message_template]
					@message_template = MessageTemplate.find(params[:id])
					@message_template.attributes = message_template
					@message_template.save!
					flash[:notice] = t(:updated)
					respond_with(@message_template, :location => message_templates_path)
				end

			rescue ActiveRecord::RecordInvalid => error
				@message_template = error.record
				respond_with(@message_template) do |format|
					format.html {	render(:edit) }
				end
			end
		end

		#
		def destroy
			MessageTemplate.transaction do
				@message_template = MessageTemplate.find(params[:id])
				@message_template.destroy
				flash[:notice] = t(:destroyed)
				respond_with(@message_template, :location => message_templates_path)
			end
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:sms, :message_templates])
		end
	end
end
