require 'rails_helper'

RSpec.describe 'customer serializer' do
  it 'serializes customers data into json' do
    customer1 = Customer.create!(first_name: 'Jamie', last_name: 'Pace', email: 'fake_email@email.com', address: '123 Address, CO')
    customer_json = JSON.parse(CustomerSerializer.new(customer1).to_json, symbolize_names: true)

    expect(customer_json).to be_a(Hash)
    expect(customer_json).to have_key(:data)
    expect(customer_json[:data]).to have_key(:id)
    expect(customer_json[:data]).to have_key(:type)
    expect(customer_json[:data]).to have_key(:attributes)
    expect(customer_json[:data][:id]).to be_a(String)
    expect(customer_json[:data][:type]).to eq("customer")
    expect(customer_json[:data][:attributes]).to be_a(Hash)
    expect(customer_json[:data][:attributes]).to have_key(:first_name)
    expect(customer_json[:data][:attributes]).to have_key(:last_name)
    expect(customer_json[:data][:attributes]).to have_key(:email)
    expect(customer_json[:data][:attributes]).to have_key(:address)
    expect(customer_json[:data][:attributes][:first_name]).to be_a(String)
    expect(customer_json[:data][:attributes][:last_name]).to be_a(String)
    expect(customer_json[:data][:attributes][:email]).to be_a(String)
    expect(customer_json[:data][:attributes][:address]).to be_a(String)
  end
end
