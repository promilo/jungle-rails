require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should have a valid test' do
      @user = User.new(first_name: 'RAymond', last_name: 'CHOO', email: 'ray_cho@gmail.com',
                        password: 'iamstupid', password_confirmation: 'iamstupid')
      expect(@user).to be_present
    end
    it 'expect if  password not equal password_confirmation then raise an error' do
      @user = User.new(first_name: 'RAymond', last_name: 'CHOO', email: 'ray_cho@gmail.com',
                        password: 'iamstupid', password_confirmation: 'iamdumb')
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'The test should fail when the same email address is used' do
      @user = User.new(first_name: 'RAymond', last_name: 'CHOO', email: 'ray_cho@gmail.com',
                        password: 'iamstupid', password_confirmation: 'iamstupid')
      @user.save
      @user2 = User.new(first_name: 'asdf', last_name: 'sef', email: 'Ray_cho@gmail.com',
                        password: 'as', password_confirmation: 'as')
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")

    end
    it 'should out put an error when email is not inputed' do
      @user = User.new(first_name: 'RAymond', last_name: 'CHOO',
                        password: 'iamstupid', password_confirmation: 'iamstupid')
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")

    end
    it 'should raise an error if first_name is not inputed' do
      @user = User.new( last_name: 'CHOO', email: 'ray_cho@gmail.com',
                        password: 'iamstupid', password_confirmation: 'iamstupid')
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")

    end
    it 'should raise an error if last_name is not inputed' do
      @user = User.new(first_name: 'RAymond', email: 'ray_cho@gmail.com',
                        password: 'iamstupid', password_confirmation: 'iamstupid')
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")

    end
    it 'should raise an error if password is less than six characters' do
      @user = User.new(first_name: 'RAymond', last_name: 'CHOO', email: 'ray_cho@gmail.com',
                        password: '123', password_confirmation: '123')
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")

    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
     before(:each) do
       @user4 = User.new(first_name: 'arjun', last_name: 'loll', email:'arjun@gmail.com', password:'miloismart', password_confirmation: 'miloismart')
       @user4.save!
     end
    it 'should normally authenticate' do
      user = User.authenticate_with_credentials('arjun@gmail.com', 'miloismart')
      expect(user).to eq(@user4)
    end
    it 'should normally authenticate with blank spaces 'do
      user = User.authenticate_with_credentials('    arjun@gmail.com  ', 'miloismart')
      expect(user).to eq(@user4)
    end
    it 'should normally authenticate with random capitalss 'do
      user = User.authenticate_with_credentials('Arjun@gmail.com  ', 'miloismart')
      expect(user).to eq(@user4)
    end

  end

end
