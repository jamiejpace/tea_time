require 'rails_helper'

RSpec.describe 'customer subscriptions endpoint' do
  it 'returns all subscriptions for a given customer' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')
    tea2 = Tea.create!(title: 'Green Tea', description: 'Great tea', temperature: 102, brew_time: '3 minutes')
    subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, title: 'Weekly Earl Grey', price: 10.00, frequency: 'weekly')
    subscription2 = Subscription.create!(customer_id: customer1.id, tea_id: tea2.id, title: 'Weekly Green Tea', price: 12.00, frequency: 'weekly')

    get "/api/v1/customers/#{customer1.id}/subscriptions"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    subscription = JSON.parse(response.body, symbolize_names: true)

    expect(subscription).to be_a(Hash)
    expect(subscription).to have_key(:data)
    expect(subscription[:data]).to be_an(Array)
    expect(subscription[:data].count).to eq(2)
  end

  it 'returns an error if customer does not exist' do
    get '/api/v1/customers/1/subscriptions'

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to have_key(:errors)
    expect(error[:errors]).to eq("Customer not found")
  end
end
