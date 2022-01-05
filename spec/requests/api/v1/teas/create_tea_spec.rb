require 'rails_helper'

RSpec.describe 'create tea endpoint' do
  it 'creates a tea' do

    body = {
      title: "Chai",
      description: "Spicy chai",
      temperature: 100,
      brew_time: "3 minutes and 30 seconds"
    }

    post '/api/v1/teas', params: body

    expect(response).to be_successful
    expect(response.status).to eq(201)

    subscription = JSON.parse(response.body, symbolize_names: true)

    expect(subscription).to have_key(:data)
    expect(subscription[:data]).to be_a(Hash)
  end

  it 'can not create a tea if title missing' do

    body = {
      description: "Spicy chai",
      temperature: 100,
      brew_time: "3 minutes and 30 seconds"
    }


    post '/api/v1/teas', params: body

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
