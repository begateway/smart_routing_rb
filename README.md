# SmartRouting

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/smart_routing`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smart_routing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smart_routing

## Usage
---------------------------

### Configuration

```ruby
# API host
SmartRouting.api_host = "https://api.smart-routing.begateway.com"
# proxy
SmartRouting.proxy = "http://192.18.10.1:3129"
# logger
SmartRouting.logger = Rails.logger
# open/read timeouts in seconds
SmartRouting.open_timeout = 5  # default: 20
SmartRouting.read_timeout = 10 # default: 40
```

### Managing accounts

```ruby
# create admin client
client = SmartRouting::Admin.new(auth_login: 'login', auth_password: 'password')

# create account
account = client.account # or SmartRouting::Admin::Account.new(client)
response = account.create(name: "Shop #1")
if response.success?
   puts "Status code" + response.status   # should return 201
   puts "Account with ID #{response.data.id} is created"
   puts response.data.to_h                # all account attributes as hash
   # or
   puts response.data.token
   puts response.data.name
   puts response.data.created_at
   puts response.data.updated_at
else         # if response.error?
  puts "Status code" + response.status    # may be 422
  puts response.error.to_h                # all error attributes as hash
  puts response.error.code
  puts response.error.message             # message for developers
  puts response.error.friendly_message    # message for users
  puts response.error.help

  # if  response.error.code == "validation_error"
  # you can retrieve all error attributes as hash
  response.error.errors                    # => {"name" => ["can't be blank"], "email" => ["is invalid"]}
end

# get account
response = account.get("111111-a343-4b24-9b03-7e1c360f7467")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all account attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# update account
response = account.update("111111-a343-4b24-9b03-7e1c360f7467", name: "New Shop")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all account attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end
```

### Managing sets

```ruby
# create user client
client = SmartRouting::User.new(auth_login: 'login', auth_password: 'account token')
# create set object
set = client.set # or SmartRouting::User::Set.new(client)

# create set
response = set.create(name: "AllowedCountries", value: ["UK", "FR"])
if response.success?
   puts "Status code" + response.status   # should return 201
   puts "Set with ID #{response.data.id} is created"
   puts response.data.to_h                # all set attributes as hash
   # or
   puts response.data.value
   puts response.data.name
   puts response.data.created_at
   puts response.data.updated_at
   puts response.data.read_only   # if this attribute is true you can not update it (this set was created by admin)
else         # if response.error?
  puts "Status code" + response.status    # may be 422
  puts response.error.to_h                # all error attributes as hash
  puts response.error.code
  puts response.error.message             # message for developers
  puts response.error.friendly_message    # message for users
  puts response.error.help

  # if  response.error.code == "validation_error"
  # you can retrieve all error attributes as hash
  response.error.errors                    # => {"name" => ["can't be blank"], "value" => ["is invalid"]}
end

# update set
response = set.update("111111-a343-4b24-9b03-7e1c360f7467", value: ["FR", "DE"])
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all set attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get set
response = set.get("111111-a343-4b24-9b03-7e1c360f7467")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all set attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get all sets
response = set.all
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data                    # array of all sets
   response.data.each do |item|
     puts "item attributes: #{item.to_h}" # all set attributes as hash for current item
     # or
     puts "Set name:  #{item.name}"
     puts "Set value: #{item.value}"
     puts "Read only? #{item.read_only}"
   end
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end
```

### Managing object_types

```ruby
# create user client
client = SmartRouting::User.new(auth_login: 'login', auth_password: 'account token')
# create object_type object
object_type = client.object_type # or SmartRouting::User::ObjectType.new(client)

# create object_type
response = object_type.create(name: "gw_EU")
if response.success?
   puts "Status code" + response.status   # should return 201
   puts "ObjectType with ID #{response.data.id} is created"
   puts response.data.to_h                # all object_type attributes as hash
   # or
   puts response.data.name
   puts response.data.created_at
   puts response.data.updated_at
else         # if response.error?
  puts "Status code" + response.status    # may be 422
  puts response.error.to_h                # all error attributes as hash
  puts response.error.code
  puts response.error.message             # message for developers
  puts response.error.friendly_message    # message for users
  puts response.error.help

  # if  response.error.code == "validation_error"
  # you can retrieve all error attributes as hash
  response.error.errors                    # => {"name" => ["can't be blank"]}
end

# update object_type
response = object_type.update("111111-a343-4b24-9b03-7e1c360f7467", name: "gw_Europe")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all object_type attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get object_type
response = object_type.get("111111-a343-4b24-9b03-7e1c360f7467")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all object_type attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get all object_types
response = object_type.all
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data                    # array of all object_types
   response.data.each do |item|
     puts "item attributes: #{item.to_h}" # all object_type attributes as hash for current item
     # or
     puts "ObjectType name:  #{item.name}"
   end
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end
```

### Managing objects

```ruby
# create user client
client = SmartRouting::User.new(auth_login: 'login', auth_password: 'account token')
# create object
object = client.object # or SmartRouting::User::Object.new(client)

# create object
type_id = "02c07bce-3a10-418e-9d77-d2c57c9bc71c"
response = object.create(name: "gw_UK", output_value: "1288", type_id: type_id)
if response.success?
   puts "Status code" + response.status   # should return 201
   puts "Object with ID #{response.data.id} is created"
   puts response.data.to_h                # all object attributes as hash
   # or
   puts response.data.name
   puts response.data.output_value
   puts response.data.type_id
   puts response.data.created_at
   puts response.data.updated_at
else         # if response.error?
  puts "Status code" + response.status    # may be 422
  puts response.error.to_h                # all error attributes as hash
  puts response.error.code
  puts response.error.message             # message for developers
  puts response.error.friendly_message    # message for users
  puts response.error.help

  # if  response.error.code == "validation_error"
  # you can retrieve all error attributes as hash
  response.error.errors                    # => {"name" => ["can't be blank"]}
end

# update object
response = object.update("111111-a343-4b24-9b03-7e1c360f7467", name: "gw_BY")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all object attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get object
response = object.get("111111-a343-4b24-9b03-7e1c360f7467")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all object attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get all object
response = object.all
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data                    # array of all object
   response.data.each do |item|
     puts "item attributes: #{item.to_h}" # all object attributes as hash for current item
     # or
     puts "Object name:  #{item.name}"
     puts "Object output_value:  #{item.output_value}"
   end
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end
```

### Managin rules

```ruby
# create user client
client = SmartRouting::User.new(auth_login: 'login', auth_password: 'account token')
# create rule object
rule = client.rule # or SmartRouting::User::Rule.new(client)

# create rule
description = "if bin_country == UK than return EU_GATEWAY"
conditions = [{"field" => "bin_country", "operation" => "equal", "value" => "UK"}]
object_id = "54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90"
response = client.rule.create(alias: "bin_country", active: true, priority: 5,
                              description: description, conditions: conditions,
                              objects: [object_id], handing_out_method: "weight",
                              weights: {object_id => 10})
if response.success?
   puts "Status code" + response.status   # should return 201
   puts "Rule with ID #{response.data.id} is created"
   puts response.data.to_h                # all rule attributes as hash
   # or
   puts response.data.alias
   puts response.data.description
   puts response.data.conditions
   puts response.data.active
   puts response.data.priority
   puts response.data.objects
   puts response.data.handing_out_method
   puts response.data.weights
   puts response.data.created_at
   puts response.data.updated_at
else         # if response.error?
  puts "Status code" + response.status    # may be 422
  puts response.error.to_h                # all error attributes as hash
  puts response.error.code
  puts response.error.message             # message for developers
  puts response.error.friendly_message    # message for users
  puts response.error.help

  # if  response.error.code == "validation_error"
  # you can retrieve all error attributes as hash
  response.error.errors                    # => {"alias" => ["can't be blank"]}
end

# update rule
response = rule.update("111111-a343-4b24-9b03-7e1c360f7467", alias: "bin_country_uk")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all rule attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get rule
response = rule.get("111111-a343-4b24-9b03-7e1c360f7467")
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data.to_h               # all rule attributes as hash
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end

# get all rules
response = rule.all
if response.success?
   puts "Status code" + response.status  # should return 200
   puts response.data                    # array of all rule
   response.data.each do |item|
     puts "item attributes: #{item.to_h}" # all rule attributes as hash for current item
     # or
     puts "Rule alias:  #{item.alias}"
     puts "Rule description:  #{item.description}"
     puts "Rule conditions: #{item.conditions}"
     puts "Rule active?: #{item.active}"
     puts "Rule priority: #{item.priority}"
     puts "Rule objects: #{item.objects}"
     puts "Rule handing out method: #{item.handing_out_method}"
     puts "Rule weights: #{item.weights}"
   end
else         # if response.error?
  puts "Status code" + response.status   # may be 404
  puts response.error.to_h               # all error attributes as hash
end
```

### Rule verification

```ruby
# create user client
client = SmartRouting::User.new(auth_login: 'login', auth_password: 'account token')
# create rule object
rule = client.rule # or SmartRouting::User::Rule.new(client)
# verify rules
response = rule.verify(bin_country: "UK", card_bin: "US", txn_amount: 150, txn_currency: "EUR")
if response.success?
   puts "Status code" + response.status   # should return 200
   puts response.data.to_h                # all account attributes as hash
   # or
   # when rule is matched
   puts response.data.object              # returend_object_value
   puts response.data.rules               # [{"state"=>"matched","description"=>"..","alias"=>"card_bin_country"}]
   # when rule is not metched
   puts response.data.object              # nil
   puts response.data.rules               # [{"state"=>"no_matched","description"=>"..","alias"=>"card_bin_country"}]
else         # if response.error?
  puts "Status code" + response.status    # may be 422
  puts response.error.to_h                # all error attributes as hash
end

# for testing verification you should sendt test = true
response = rule.verify(test: true, bin_country: "UK", card_bin: "US")
 ```


### Adding data (after finalizing transaction)

```ruby
# create user client
client = SmartRouting::User.new(auth_login: 'login', auth_password: 'account token')
# create data object
data_obj = client.data # or SmartRouting::User::Data.new(client)

# add data
created_at = Time.now.utc.iso8601(3) # when there is ActiveSupport
response = data.add(created_at: created_at, txn_amount: 100, txn_currency: "BYN", txn_type: "capture")
if response.success?
   puts "Status code" + response.status   # should return 204
else         # if response.error?
  puts "Status code" + response.status    # may be 422
  puts response.error.to_h                # all error attributes as hash
  puts response.error.code
  puts response.error.message             # message for developers
  puts response.error.friendly_message    # message for users
  puts response.error.help

  # if  response.error.code == "validation_error"
  # you can retrieve all error attributes as hash
  response.error.errors                    # => {"created_at" => ["can't be blank"]}
end


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/begateway/smart_routing_rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
