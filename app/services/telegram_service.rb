module TelegramService

  require 'telegram/bot'

  @bot = Telegram::Bot::Api.new(ENV['TELEGRAM_BOT_TOKEN'])

  def self.broadcast(message)
    @bot.send_message(chat_id: ENV['TELEGRAM_BOT_GROUP_ID'], text: message)
  end

end