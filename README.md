# Crunchbase

Crunchbase API v3.1 - Ruby Library [CrunchBase Data Hub](https://data.crunchbase.com/v3.1/docs/using-the-api).

### How to installation

Add this line to your application's Gemfile:

    gem 'ruby_crunchbase_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_crunchbase_api

### Certificate (User Key)

cCeate the file `config/initializers/crunchbase.rb` in your rails project and add user_key.

    require 'crunchbase'

    Crunchbase::API.key = 'user_key'
    Crunchbase::API.debug = false

#### Getting the Item by uuid or permalink...

    person = Person.get("mark-zuckerberg")
    company = Organization.get("facebook")

#### Searching by Object...

    search_results = Person.search({"name": "mark"})
    #get the next page of results
    search_results = search_results.next

#### Searching through API directly...

    API.get("https://api.crunchbase.com/v3.1/organizations?name=facebook")
    API.batch({"requests": [
      { "type": "<entity_type>", "uuid": "<entity_uuid>", "relationships": ["<relationship_name>"]}
    ]})


### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Copyright

Copyright © 2019 Nolan Frausto. See LICENSE for details.
