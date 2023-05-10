class ApplicationController < ActionController::Base
  around_action :switch_locale

  def update_turbo(channel:, partial:, locals:, target:)
    Turbo::StreamsChannel.broadcast_update_to(channel, partial:, locals:, target:)
  end

  def update_room_content(room)
    update_turbo(
      channel: "room_#{room.id}",
      partial: "rooms/content",
      locals: { room: room },
      target: "room_content_#{room.id}"
    )
  end

  private

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]

    return locale if I18n.available_locales.map(&:to_s).include?(locale)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
