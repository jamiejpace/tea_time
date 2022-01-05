require 'rails_helper'

RSpec.describe 'subscribe customer endpoint' do
  it 'creates a subscription for a customer to a given tea' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')

    body = {
      tea_id: tea1.id,
      title: 'Weekly Earl Grey',
      price: 10.00,
      frequency: 'weekly'
    }

    post "/api/v1/customers/#{customer1.id}/subscriptions", params: body

    expect(response).to be_successful
    expect(response.status).to eq(201)

    subscription = JSON.parse(response.body, symbolize_names: true)

    expect(subscription).to have_key(:data)
    expect(subscription[:data]).to be_a(Hash)
  end

  it 'can not create a subscription if attributes are missing' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')

    body = {
      tea_id: tea1.id
    }

    post "/api/v1/customers/#{customer1.id}/subscriptions", params: body

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'can not create a subscription if customer not valid' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')

    body = {
      tea_id: tea1.id,
      title: 'Weekly Earl Grey',
      price: 10.00,
      frequency: 'weekly'
    }

    post '/api/v1/customers/999999/subscriptions', params: body

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'can not create a subscription if tea not valid' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')

    body = {
      tea_id: 4444,
      title: 'Weekly Earl Grey',
      price: 10.00,
      frequency: 'weekly'
    }

    post "/api/v1/customers/#{customer1.id}/subscriptions", params: body

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
