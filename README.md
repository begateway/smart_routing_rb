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
  subject.error.errors                    # => {"name" => ["can't be blank"], "email" => ["is invalid"]}
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

### Managin sets

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
  subject.error.errors                    # => {"name" => ["can't be blank"], "value" => ["is invalid"]}
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/begateway/smart_routing_rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
