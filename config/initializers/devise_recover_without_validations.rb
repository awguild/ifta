Devise::Models::Recoverable.module_eval do
 def reset_password! new_password, new_password_confirmation
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    
    if new_password == new_password_confirmation
      clear_reset_password_token
      after_password_reset
      return save(:validate => false)
    end

    return false
 end
end