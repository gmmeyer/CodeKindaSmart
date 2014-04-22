require 'spec_helper'

describe User do
  let(:session_token) do
    SecureRandom::urlsafe_64(32)
  end
  describe "Validations" do
    context "on a new user" do
      it "should not be valid without a password" do
        user = User.new username: 'testing', email: 'test@test.test',
          password: nil, password_confirmation: nil,
          session_token: session_token
        user.should_not be_valid
      end

      it "should be not be valid with a short password" do
        user = User.new username: 'testing', email: 'test@test.test',
          password: 'short', password_confirmation: 'short',
          session_token: session_token
        user.should_not be_valid
      end

      it "should not be valid with a confirmation mismatch" do
        user = User.new username: 'testing', email: 'test@test.test',
          password: 'short', password_confirmation: 'long',
          session_token: session_token
        user.should_not be_valid
      end
    end

    context "on an existing user" do
      let(:user) do
        u = User.create username: 'testing', email: 'test@test.test',
          password: 'password', password_confirmation: 'password',
          session_token: session_token
        User.find u.id
      end

      it "should be valid with no changes" do
        user.should be_valid
      end

      it "should be valid with a new (valid) password" do
        user.password = user.password_confirmation = "new password"
        user.should be_valid
      end
    end
  end
end