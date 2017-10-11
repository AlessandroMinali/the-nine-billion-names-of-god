require 'erb'
require 'sequel'

db = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://names.db')
db.create_table :gods do
  primary_key :id
  String :name
end rescue nil
class God < Sequel::Model; end
God.create(name: '') if God.first.nil?

# Reveal all 9 billion names of GOD
class NamesOfGod
  # https://en.wikipedia.org/wiki/Rotokas_alphabet
  ALPHA = %w[a e g i k n o p r s t u v].freeze

  def call(env)
    if env['REQUEST_METHOD'] == 'GET' && env['REQUEST_PATH'] == '/'
      @headers = { 'Content-Type' => 'text/html' }

      @name = next_god(God.first.destroy.name)
      God.create(name: @name)

      @body = ERB.new(File.read('./index.html')).result(binding)

      update_content_length
      [200, @headers, [@body]]
    else
      [400, { 'Content-Type' => 'text/html' }, ['You are on the wrong path to &lt;GOD&gt;.']]
    end
  end

  private

  def next_god(name)
    return 'a' if name.empty?
    letter_index = ALPHA.index(name[-1]).next
    name_start = name[0...-1]
    name_start = next_god(name[0...-1]) if letter_index > ALPHA.length - 1
    name = name_start + ALPHA[letter_index % ALPHA.length]
    return next_god(name) if triples?(name)
    name
  end

  def triples?(name)
    ALPHA.any? do |i|
      /#{i}{3}/.match(name)
    end
  end

  def update_content_length
    @headers['Content-Length'] = @body.to_s
  end
end
