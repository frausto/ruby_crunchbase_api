# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Person do
      
      describe "get" do

        before do
          resp = File.join(File.dirname(__FILE__), "../data/people", "mark-zuckerberg.json")
          stub_request(:get, "https://api.crunchbase.com/v3.1/people/mark-zuckerberg?user_key=35f94fa4f3f38152b40353b31232a913").
           to_return(status: 200, body: IO.read(resp), headers: {})
        end
        it 'should return the person' do
          person = Person.get("mark-zuckerberg")
          expect(person.type).to eq('Person')
          expect(person.uuid).to eq('a01b8d46d31133337c34aa3ae9c03f22')
          expect(person.first_name).to eq('Mark')
          expect(person.last_name).to eq('Zuckerberg')
          expect(person.full_name).to eq('Mark Zuckerberg')
          expect(person.gender).to eq('Male')
          expect(person.born_on).to eq(Date.parse('1984-05-14'))
          expect(person.role_investor).to eq(true)
        end
      end
    end
  end
end