require './lib/station'

describe Station do

  it 'returns a #name' do
    station = Station.new("name",1)
    expect(station.name).to eq "name"
  end

  it 'returns a #zone' do
    station = Station.new("name",1)
    expect(station.zone).to eq 1
  end


end
