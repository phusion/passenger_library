# A monkeypatch for the Kramdown Markdown renderer. Improves automatic header ID generation by preserving underscores.
Kramdown::Converter::Base.class_eval do
  def generate_id(str)
    str = ::Kramdown::Utils::Unidecoder.decode(str) if @options[:transliterated_header_ids]
    gen_id = str.gsub(/^[^a-zA-Z]+/, '')
    gen_id.tr!('^a-zA-Z0-9 -_', '')
    gen_id.tr!(' ', '-')
    gen_id.downcase!
    gen_id = 'section' if gen_id.length == 0
    @used_ids ||= {}
    if @used_ids.has_key?(gen_id)
      gen_id += '-' << (@used_ids[gen_id] += 1).to_s
    else
      @used_ids[gen_id] = 0
    end
    @options[:auto_id_prefix] + gen_id
  end
end
