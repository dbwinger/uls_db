# UlsDb

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/uls_db`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uls_db'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uls_db

## Usage

TODO: 
From project root directory
`irb -r ./lib/uls_db.rb`
Then use any of the service classes

## Development

To get db/schema.sql from https://www.fcc.gov/sites/default/files/public_access_database_definitions_sql_v1.txt, make the following replacements:
* 'dbo.PUBACC' => 'uls'
* ')\n' => ');'
* 'offset' => '"offset"'
* 'tinyint' => 'int'
* 'datetime' => 'timestamp'

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/uls_db.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
