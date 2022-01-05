require 'rails_helper'

RSpec.describe 'cancel subscription endpoint' do
  it 'changes the status to cancelled for a given subscription' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')
    subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, title: 'Weekly Earl Grey', price: 10.00, frequency: 'weekly')

    patch "/api/v1/subscriptions/#{subscription1.id}", params: { status: "cancelled" }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    subscription = JSON.parse(response.body, symbolize_names: true)

    expect(subscription[:data][:attributes][:status]).to eq('cancelled')
  end

  it 'returns an error if the subscription does not exist' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')

    patch '/api/v1/subscriptions/8888', params: { status: "cancelled" }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'returns an error if given an invalid status' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')
    subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, title: 'Weekly Earl Grey', price: 10.00, frequency: 'weekly')

    patch "/api/v1/subscriptions/#{subscription1.id}", params: { status: 'pending' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
