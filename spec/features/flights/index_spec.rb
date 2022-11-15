require 'rails_helper' 

RSpec.describe "Flight Index" do 
  before :each do 
    @airline1 = Airline.create!(name: "Paper Plane")
    @airline2 = Airline.create!(name: "Soul Plane")
    @airline3 = Airline.create!(name: "Polar Plane")

    @flight1 = @airline1.flights.create!(number: "1111", date:"11/14/22", departure_city: "Denver", arrival_city: "Austin" )
    @flight2 = @airline1.flights.create!(number: "2222", date:"11/13/22", departure_city: "Sacramento", arrival_city: "San Diego" )
    @flight3 = @airline2.flights.create!(number: "3333", date:"11/12/22", departure_city: "Jacksonville", arrival_city: "Portland" )

    @passenger1 = Passenger.create!(name: "Goku", age: 30)
    @passenger2 = Passenger.create!(name: "Piccolo", age: 32)
    @passenger3 = Passenger.create!(name: "Vegeta", age: 31)
    @passenger4 = Passenger.create!(name: "Gohan", age: 15)

    FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger1.id )
    FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger2.id )
    FlightPassenger.create(flight_id: @flight2.id, passenger_id: @passenger3.id )
    FlightPassenger.create(flight_id: @flight3.id, passenger_id: @passenger4.id )
    FlightPassenger.create(flight_id: @flight3.id, passenger_id: @passenger1.id )

    
    visit flights_path
  end
  
  it "I see a list of all flight numbers, next to each flight number I see the name of the airline of that flight" do 

    expect(page).to have_content(@flight1.number)
    
    within "#flight-#{@flight1.id}" do 
      expect(page).to have_content(@airline1.name)
    end 


    expect(page).to have_content(@flight2.number)
    within "#flight-#{@flight2.id}" do 
      expect(page).to have_content(@airline1.name)
    end 


    expect(page).to have_content(@flight3.number)
    within "#flight-#{@flight3.id}" do 
      expect(page).to have_content(@airline2.name)
    end 


    expect(page).to_not have_content(@airline3.name)

  end