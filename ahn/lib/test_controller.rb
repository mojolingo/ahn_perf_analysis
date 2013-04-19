# encoding: utf-8
require 'yaml'

class TestController < Adhearsion::CallController

  def run
    logger.warn "VALUE OF AHN_PB_PLATFORM IS: #{ENV['AHN_PUNCHBLOCK_PLATFORM']}"
    menus = YAML.load_file 'lib/menus.yml'
    answer
    menus.each { |m| test_menu m }
    play sound_file 'tt-monkeys'
  end

  def test_menu(opts)
    menu "#{sound_file opts['sound']}" do
      match(opts['incorrect_dtmf']) { hangup }
      match(opts['dtmf'])           { nil }
    end
  end

  def sound_file(filename)
    file_path = File.expand_path "./sounds/#{filename}.gsm"
    sound = case ENV['AHN_PUNCHBLOCK_PLATFORM']
    when "xmpp"
      "file://#{file_path}"
    when "freeswitch"
      file_path
    when "asterisk"
      filename
    end
    sound
  end

end
