class Users::SessionsController < Devise::SessionsController
  after_action :remove_notice

  private

  def remove_notice
    flash.discard(:notice) #http://api.rubyonrails.org/v5.1/classes/ActionDispatch/Flash/FlashHash.html#method-i-discard
  end
end
