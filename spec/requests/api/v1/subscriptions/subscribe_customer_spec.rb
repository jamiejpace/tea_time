require 'rails_helper'

RSpec.describe 'subscribe customer endpoint' do
  it 'creates a subscription for a customer to a given tea' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')

    body = {
      customer_id: customer1.id,
      tea_id: tea1.id,
      title: 'Weekly Earl Grey',
      price: 10.00,
      frequency: 'weekly'
    }

    post '/api/v1/subscriptions', params: body

    expect(response).to be_successful
    expect(response.status).to eq(201)
  end
end
