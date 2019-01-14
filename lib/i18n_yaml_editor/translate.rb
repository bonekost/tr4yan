require_relative "app"

module I18nYamlEditor
  class Translate

    def app
      I18nYamlEditor.app
    end

    def send_translation
      options = {}
      options[:key] = /#{filters["key"]}/ if filters["key"].to_s.size > 0
      options[:text] = /#{filters["text"]}/i if filters["text"].to_s.size > 0
      options[:complete] = false if filters["incomplete"] == "on"
      options[:empty] = true if filters["empty"] == "on"

      keys = app.store.filter_keys(options)

      categories = app.store.categories.sort

      translations.each {|name, text|
        app.store.translations[name].text = text
      }
      app.save_translations

      values = app.store.translations.values
    end
  end
end
