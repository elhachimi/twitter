require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not presnt" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid} 
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo user_at_foo.org example.iser@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
      	@user.email = invalid_address
      	expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
    	adresses = %w[user@foo.COM A_US-ER@f.b.org fest.lst@foo.jp a+b@baz.cn]
    	adresses.each do |valid_email|
    		@user.email = valid_email
    		expect(@user).to be_valid
    	end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    
    before do
    	@user = User.new(name:"example user", email:"example@email.org", password:" ",password_confirmation:" ")
    end

    it { should_not be_valid}
  end

  describe "when a password is too short" do

  	before { @user.password = @user.password_confirmation = 'a'*5 }
  	it { should_not be_valid }

  end

 	describe "when password confirmation don't match" do
 	  
 	  before { @user.password_confirmation = "mismatch"}
 	  it { should_not be_valid}
 	end

 	describe "return value of authenticate method" do
 	  before { @user.save }
 	  let(:found_user){ User.find_by(email: @user.email) }

 	  describe "with valid password" do
 	    it { should eq found_user.authenticate(@user.password) }
 	  end

 	  describe "with invalid password" do
 	  	let(:user_with_invalid_password) { found_user.authenticate("invalid") }
 	  	it { should_not eq user_with_invalid_password }
 	  	specify { expect(user_with_invalid_password).to be_false }
 	  end

 	end
end
