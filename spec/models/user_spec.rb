require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.by_username' do
    let!(:user_1) { create(:user, username: 'john_doe') }
    let!(:user_2) { create(:user, username: 'doe_john') }
    let!(:user_3) { create(:user, username: 'johnny') }
    let!(:user_4) { create(:user, username: 'jane_doe') }

    context 'when searching for a partial username' do
      it 'returns users with matching usernames' do
        result = User.by_username('john')
        expect(result).to include(user_1, user_2, user_3)
        expect(result).not_to include(user_4)
      end
    end

    context 'when searching for an exact username' do
      it 'returns only the users with the exact username' do
        result = User.by_username('john_doe')
        expect(result).to include(user_1)
        expect(result).not_to include(user_2, user_3, user_4)
      end
    end

    context 'when no username is given' do
      it 'returns all users' do
        result = User.by_username(nil)
        expect(result).to include(user_1, user_2, user_3, user_4)
      end
    end
  end
end
