require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Comments Validations, Maximum size, length and presence' do
    let(:user) { User.create(name: 'Gabriel Hilarion', email: 'gabriel@gmail.com', password: '123456') }
    let(:post) { Post.create(user_id: user.id, content: 'This is my first post') }

    subject { post.comments.build(user_id: user.id, content: 'Hey, yeah, nice post ') }

    it 'Maximun size of content is 200' do
      expect(subject).to be_valid
    end

    it { expect(subject).to validate_presence_of(:content) }

    it {
      expect(subject).to validate_length_of(:content).is_at_most(200)
        .with_message(/200 characters in comment is the maximum allowed./)
    }
  end

  context 'Association' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:post) }
  end
end