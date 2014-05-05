module Controller
  module SignInHelpers
    def sign_in_user(user)
      user = send(user.to_sym)

      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user

        controller.stub(:current_user) { user }
      end
    end

    def sign_out
      before(:each) do
        sign_out :user
      end
    end

    private
      def user
        return FactoryGirl.create(:user)
      end

      def judge
        return FactoryGirl.create(:judge)
      end
  end
end
