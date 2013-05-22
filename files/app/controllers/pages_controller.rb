class PagesController < ApplicationController

  def home
    @page = localized_page unless signed_in?
  end

  private

    def localized_page
      "#{Rails.root}/config/locales/#{controller_name}/"\
        "#{action_name}/#{action_name}.#{I18n.locale}.md"
    end
end
