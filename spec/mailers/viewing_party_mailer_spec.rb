require 'rails_helper'

describe ViewingPartyMailer, type: :mailer do
  describe 'inform' do
    user = User.create(name: 'Rey',
                       email: 'rey@starwars.com',
                       password: 'notthebestjedi')
    email_info = {user: user,
                  message: 'Happy trails',
                  friend: 'The Emperor'}
    let(:mail) { ViewingPartyMailer.inform(email_info, 'thedarksiderules@deathstar.com') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Rey invited you to a movie night!')
      expect(mail.to).to eq(['thedarksiderules@deathstar.com'])
      expect(mail.from).to eq(['from@example.com'])
      expect(mail.reply_to).to eq(['rey@starwars.com'])
    end


  end
end 
