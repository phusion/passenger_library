module CustomHelpers
  def installation_manual_title(options)
    if options[:upgrade]
      result = "Upgrading "
    else
      result = "Installing "
    end
    result << "Phusion Passenger via "
    case options[:install_method]
    when "rvm"
      result << "RVM and "
    when "rbenv"
      result << "rbenv and "
    when "chruby"
      result << "chruby and "
    else
      raise "Unknown install_method"
    end
    result << "RubyGems"
    result
  end

  def next_step_number
    @next_step_number ||= 1
    result = @next_step_number
    @next_step_number += 1
    result
  end
end
