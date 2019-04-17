class PagesController < ApplicationController
	def about
		@rails_ver = Rails.version
		@ruby_ver = RUBY_VERSION
		@env = Rails.env
		@current_time = Time.current
	end
end
