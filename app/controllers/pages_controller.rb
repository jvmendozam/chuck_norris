class PagesController < ApplicationController

  def dashboard
    flash[:alert] = "t('pages.dashboard.no_content')"
  end

  def detect_locale
    # You can parse yourself the accept-language header if you don't use the browser gem
    languages = browser.accept_language.map(&:code)

    # Select the first language available, fallback to english
    locale = languages.find { |l| I18n.available_locales.include?(l.to_sym) } || :en

    redirect_to root_path(locale: locale)
  end
end