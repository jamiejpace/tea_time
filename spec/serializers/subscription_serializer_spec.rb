require 'rails_helper'

RSpec.describe 'subscription serializer' do
  it 'serializes subscriptions data into json' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')
    subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, title: 'Weekly Earl Grey', price: 10.00, frequency: 'weekly')

    subscription_json = JSON.parse(SubscriptionSerializer.new(subscription1).to_json, symbolize_names: true)

    expect(subscription_json).to be_a(Hash)
    expect(subscription_json).to have_key(:data)
    expect(subscription_json[:data]).to be_a(Hash)
    expect(subscription_json[:data]).to have_key(:id)
    expect(subscription_json[:data]).to have_key(:type)
    expect(subscription_json[:data]).to have_key(:attributes)
    expect(subscription_json[:data][:id]).to be_a(String)
    expect(subscription_json[:data][:type]).to eq('subscription')
    expect(subscription_json[:data][:attributes]).to be_a(Hash)
    expect(subscription_json[:data][:attributes]).to have_key(:customer_id)
    expect(subscription_json[:data][:attributes]).to have_key(:tea_id)
    expect(subscription_json[:data][:attributes]).to have_key(:title)
    expect(subscription_json[:data][:attributes]).to have_key(:price)
    expect(subscription_json[:data][:attributes]).to have_key(:frequency)
    expect(subscription_json[:data][:attributes]).to have_key(:status)
    expect(subscription_json[:data][:attributes][:customer_id]).to be_a(Integer)
    expect(subscription_json[:data][:attributes][:tea_id]).to be_a(Integer)
    expect(subscription_json[:data][:attributes][:title]).to be_a(String)
    expect(subscription_json[:data][:attributes][:price]).to be_a(Float)
    expect(subscription_json[:data][:attributes][:frequency]).to be_a(String)
    expect(subscription_json[:data][:attributes][:status]).to be_a(String)
  end
end
