if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all
  # Monkey patch to fix issues with Haml templates not being recognised
  Footnotes::Notes::LogNote::LoggingExtensions.module_eval do
    def add(*args, &block)
      super
      logged_message = args[2] + "\n"
      Footnotes::Notes::LogNote.log(logged_message)
      logged_message
    end
  end

  # Open footnotes with Sublime Text 2
  Footnotes::Filter.prefix = 'subl://open?url=file://%s&line=%d&column=%d'
end