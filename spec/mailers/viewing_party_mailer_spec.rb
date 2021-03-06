require 'rails_helper'

describe ViewingPartyMailer, type: :mailer do
  describe 'inform' do
    user = User.create(name: 'Rey',
                       email: 'rey@starwars.com',
                       password: 'notthebestjedi')
    emperor = User.create(name: 'The Emperor',
                          email: 'thedarksiderules@deathstar.com',
                          password: 'jedisux')
    email_info = {user: user,
                  message: 'Happy trails',
                  friend: emperor }
    let(:mail) { ViewingPartyMailer.inform(email_info, 'thedarksiderules@deathstar.com') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Rey invited you to a movie night!')
      expect(mail.to).to eq(['thedarksiderules@deathstar.com'])
      expect(mail.from).to eq(['from@example.com'])
      expect(mail.reply_to).to eq(['rey@starwars.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include('Hello The Emperor!')
      expect(mail.text_part.body.to_s).to include('Rey has invited you to watch Happy trails!')
      expect(mail.html_part.body.to_s).to include('Hello The Emperor!')
      expect(mail.html_part.body.to_s).to include('Rey has invited you to watch Happy trails!')
      expect(mail.body.encoded).to include('Hello The Emperor!')
      expect(mail.body.encoded).to include('Rey has invited you to watch Happy trails!')
    end
  end
end 
