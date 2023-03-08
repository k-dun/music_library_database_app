require "spec_helper"
require "rack/test"
require_relative '../../app'


describe Application do
  
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums" do
    it 'creates a new album and returns 200 OK' do
      response = post('/albums', title: 'Voyage', release_year: 2022, artist_id: 2)

      expect(response.status).to eq(200)

      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end

  context 'POST /artists' do
    it 'adds a new artist and returns 200 OK' do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq(200)

      response = get('/artists')
      expect(response.body).to include('Wild nothing')
    end
  end

  context 'GET /artists' do
    it 'returns 200 OK and the list of artists' do
      response = get('/artists')

      artists = "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing"

      expect(response.status).to eq(200)
      expect(response.body).to eq(artists)
    end
  end
end
