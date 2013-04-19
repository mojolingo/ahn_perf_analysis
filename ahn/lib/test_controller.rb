# encoding: utf-8
class TestController < Adhearsion::CallController

  def run
    answer
    menu sound_file 'tt-monkeys' do
      match(4) { nil }
    end
    menu sound_file 'tt-weasels' do
      match(8) { nil }
    end
    menu sound_file 'tt-somethingwrong' do
      match(9) { nil }
    end
    menu sound_file 'tt-monkeys' do
      match(1) { nil }
    end
    menu sound_file 'tt-weasels' do
      match(3) { nil }
    end
    menu sound_file 'tt-somethingwrong' do
      match(7) { nil }
    end
    menu sound_file 'tt-monkeys' do
      match(4) { nil }
    end
    menu sound_file 'tt-weasels' do
      match(8) { nil }
    end
    menu sound_file 'tt-somethingwrong' do
      match(9) { nil }
    end
    menu sound_file 'tt-monkeys' do
      match(1) { nil }
    end
    menu sound_file 'tt-weasels' do
      match(3) { nil }
    end
    menu sound_file 'tt-somethingwrong' do
      match(7) { nil }
    end
    play sound_file 'tt-monkeys'
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
