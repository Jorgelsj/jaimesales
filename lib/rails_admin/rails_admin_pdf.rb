module RailsAdminPdf
end

require 'rails_admin/config/actions'

module RailsAdmin
	module Config
		module Actions
			class Pdf < Base
				RailsAdmin::Config::Actions.register(self)

				register_instance_option :member do
					true
				end

				register_instance_option :controller do
					Proc.new do
						#Aqui vem seu codigo
						redirect_to :back
					end
				end

				register_instance_option :link_icon do
					'icon-folder-open'
				end
			end
		end
	end
end
