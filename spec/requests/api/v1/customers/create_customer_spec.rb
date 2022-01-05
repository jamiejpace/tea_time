require 'rails_helper'

RSpec.describe 'create customer endpoint' do
  it 'creates a customer' do

    body = {
      first_name: 'Mose',
      last_name: 'The Dog',
      email: 'barkbark@fake_email.com',
      address: '123 Street Address, CO'
    }

    post "/api/v1/customers", params: body

    expect(response).to be_successful
    expect(response.status).to eq(201)

    subscription = JSON.parse(response.body, symbolize_names: true)

    expect(subscription).to have_key(:data)
    expect(subscription[:data]).to be_a(Hash)
  end

  it 'can not create a customer if attributes missing' do

    body = {
      first_name: 'Mose',
      last_name: 'The Dog',
    }

    post "/api/v1/customers", params: body

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
