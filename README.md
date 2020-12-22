# Kokonfig

Kokonfig is a command line utility that generates multiple versions of files based on ERB templates and data YAML files.

Kokonfig can be used to generate config files for each environment in your application when each config mostly contains the same structure but values depend on the environment. It can also be useful when config files contain several repeated values.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kokonfig'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install kokonfig

## Usage

For each set of output files, you need to create an input YAML data file and an ERB template. For each version defined by these two files, Kokonfig will output one file. You just need to put the input files in default directories and run the following command:

```
kokonfig
```

### Config files

The data file must be a YAML file containing a mapping and its root level keys will be the name of each output version. Inner keys will be values that can be used in the ERB template file.

The data file name will define what will be the template file and output file names. Everything before the *.yml* extension is the base file name. The template file has to be named with that base file name concatenated with the extension *.erb*. The output files generated will be named with the base file name with each version string before the file extension. The example below will make this clear.

Data files are read from *./config/kokonfig/data* and template files directory is at *./config/kokonfig/templates*. Output files are created in the current working directory. 

### Example

Create a data file *./config/kokonfig/data/result.txt.yml*:

```
production:
  country: Australia
  language: english  
development:
  country: Brazil
  language: portuguese
```

Create a template file *./config/kokonfig/templates/result.txt.erb*:

```
In <%= country %> people speak <%= language %>!
```

After runnning *kokonfig* you should see two files in your current working directory named *result.production.txt* and *result.development.txt*. The file *result.production.txt* should contain:

```
In Australia people speak english!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elciok/kokonfig.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
