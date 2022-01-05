require 'rails_helper'

RSpec.describe 'tea serializer' do
  it 'serializes tea data into json' do
    tea1 = tea1 = Tea.create!(title: 'Earl Grey', description: 'Good tea', temperature: 100, brew_time: '5 minutes')
    tea_json = JSON.parse(TeaSerializer.new(tea1).to_json, symbolize_names: true)

    expect(tea_json).to be_a(Hash)
    expect(tea_json).to have_key(:data)
    expect(tea_json[:data]).to have_key(:id)
    expect(tea_json[:data]).to have_key(:type)
    expect(tea_json[:data]).to have_key(:attributes)
    expect(tea_json[:data][:id]).to be_a(String)
    expect(tea_json[:data][:type]).to eq("tea")
    expect(tea_json[:data][:attributes]).to be_a(Hash)
    expect(tea_json[:data][:attributes]).to have_key(:title)
    expect(tea_json[:data][:attributes]).to have_key(:description)
    expect(tea_json[:data][:attributes]).to have_key(:temperature)
    expect(tea_json[:data][:attributes]).to have_key(:brew_time)
    expect(tea_json[:data][:attributes][:title]).to be_a(String)
    expect(tea_json[:data][:attributes][:description]).to be_a(String)
    expect(tea_json[:data][:attributes][:temperature]).to be_a(Integer)
    expect(tea_json[:data][:attributes][:brew_time]).to be_a(String)
  end
end
