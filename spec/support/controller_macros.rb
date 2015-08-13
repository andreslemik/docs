module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      sign_in :user, admin # sign_in(scope, resource)
    end
  end

  def login_logist
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:logist]
      user = FactoryGirl.create(:logist)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
  
  def login_distributor
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:distributor]
      user = FactoryGirl.create(:distributor)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
  
  # def create_cities
    # before(:each) do
      # FactoryGirl.create_list(:city, 10)
    # end
  # end
end