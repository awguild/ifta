ActiveSupport::Deprecation.behavior = lambda do |msg, stack|
  unless /LIBRARY_NAME/ =~ msg
    # annoying deprecation message, fixed here https://github.com/perfectline/validates_existence/pull/29
    # but that version of the gem has other errors, no new release yet
    unless msg.match 'You are passing an instance of ActiveRecord::Base to `exists?'
      ActiveSupport::Deprecation::DEFAULT_BEHAVIORS[:stderr].call(msg,stack) # whichever handlers you want - this is the default
    end
  end
end