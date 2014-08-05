require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test "a user should enter a first name" do
        user = User.new
        assert !user.save
        assert !user.errors[:first_name].empty?
    end

    test "a user should enter a last name" do
        user = User.new
        assert !user.save
        assert !user.errors[:last_name].empty?
    end

    test "a user should enter a profile name" do
        user = User.new
        assert !user.save
        assert !user.errors[:profile_name].empty?
    end

    test "a user should have a unique profile name" do
        user = User.new
        user.profile_name = users(:vovan).profile_name
        assert !user.save
        assert !user.errors[:profile_name].empty?
    end

    test "a user should have a profile name without spaces" do
        user = User.new(first_name: 'vova', last_name: 'michalchenko', email: 'vovan4e@ua.fm')
        user.password = user.password_confirmation = 'password'

        user.profile_name = "My Profile With Space"

        assert !user.save
        assert !user.errors[:profile_name].empty?
        assert !user.errors[:profile_name].include?("Must be formatted correctly.")
    end

    test "a user should have a correctly formatted profile name" do
        user = User.new(first_name: 'vova', last_name: 'michalchenko', email: 'vovan4eg@ua.fm')
        user.password = user.password_confirmation = 'password'
        user.profile_name = 'vovan'

        assert user.valid?
        assert user.save
    end


end
