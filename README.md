# Gcl::FulltextSearch

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gcl/fulltext_search`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gcl-fulltext_search'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gcl-fulltext_search

## Usage

### migration file example
```ruby
class CreateArticles
    def change
        create_table :articles do |t|
            t.string :title
            t.text :body
            t.text :text_for_index
            
            t.index :text_for_index, type: :fulltext
        end
    end
end
```
### Create model
```ruby
class Article < ApplicationRecord
    scope :match, lambda { |text|
        jt = Gcl::FulltextSearch::JapaneseTokenizer.new
        where(arel_table[:text_for_index].match_against(jt.tokenize(text)))
    }
    
    before_save do
        jt = Gcl::FulltextSearch::JapaneseTokeinzer.new
        self.text_for_index = jt.tokenize(title, body)
    end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gc-ror/fulltext_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gcl::FulltextSearch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gcl-fulltext_search/blob/master/CODE_OF_CONDUCT.md).
