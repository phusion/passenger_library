# A monkeypatch for the Kramdown Markdown renderer. Improves automatic header
# ID generation by preserving underscores and by removing number prefixes.
Kramdown::Converter::Base.class_eval do
  def generate_id(str)
    str = ::Kramdown::Utils::Unidecoder.decode(str) if @options[:transliterated_header_ids]
    gen_id = str.sub(/^[0-9]+/, '') # Remove number prefixes
    gen_id.strip!
    gen_id = gen_id.scan(/[a-z0-9\-_]+/i).join("-")
    gen_id.downcase!
    gen_id = 'section' if gen_id.empty?
    @used_ids ||= {}
    if @used_ids.has_key?(gen_id)
      gen_id += '-' << (@used_ids[gen_id] += 1).to_s
    else
      @used_ids[gen_id] = 0
    end
    @options[:auto_id_prefix] + gen_id
  end
end
