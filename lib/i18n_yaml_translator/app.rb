require 'psych'
require 'yaml'
require_relative 'yandex'

module I18nYamlTranslator
  class App
    def initialize path, from_language, to_language
      @from_lang = from_language.to_s
      @to_lang = to_language.to_s
      @path = File.expand_path(path)
      @store = Store.new
      I18nYamlTranslator.app = self
      Yandex::Translate.load 'config/yandex_direct.yml'
    end

    attr_accessor :store

    def start
      $stdout.puts " * Loading translations from #{@path}"
      load_translations

      $stdout.puts " * Translating from #{@from_lang} to #{@to_lang}"
      translate_yml @from_lang, @to_lang

      $stdout.puts " * Saving translation"
      save_translations
    end

    def load_translations
      files = Dir[@path + "**/*.yml"]
      files.each {|file|
        yaml = YAML.load_file(file)
        store.from_yaml(yaml, file)
      }
    end

    def translate_yml from, to
      lang = "#{from}-#{to}"
      categories = store.categories
      categories.each do |name, category|
        options = {}
        options[:key] = /#{category.name}/
        keys = store.filter_keys(options)

        keys.each do |name, key|
          key.translations.sort_by(&:locale).each do |translation|
            if translation.locale == to && !translation.text.nil?
              t = yandex(translation.text, lang)
              translation.text = t
            end
          end
        end
      end
    end

    def yandex(text, language)
      result = Yandex::Translate.do(text, language)
      sleep 1
      return result['text'].join(' ') if result['text']
    end

    def save_translations
      files = store.to_yaml
      files.each {|file, yaml|
        File.open(file, "w", encoding: "utf-8") {|f| f << yaml.to_yaml}
      }
    end
  end
end
