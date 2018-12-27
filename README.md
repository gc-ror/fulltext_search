# Gcl::FulltextSearch

Add fulltext search feature to your rails application.

## Installation

Prepare MeCab groonga version:

    $ sudo rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm
    $ sudo yum install mecab mecab-devel mecab-ipadic
    
This is for CentOS 7.
If you use anther architecture modify this appropriately.

Then execute following line to confirm installation:

    $ echo "今日は天気です" | mecab


Add this line to your application's Gemfile:

```ruby
gem 'gcl-fulltext_search', github: 'gc-ror/gcl-fulltext_search.git'
```

And then execute:

    $ bundle

## Usage

### Migration file example
```ruby
class CreateArticles
    def change
        create_table :articles do |t|
            t.string :title
            t.text :body
            t.text :text_for_index
            
            # add fulltext index
            t.index :text_for_index, type: :fulltext
        end
    end
end
```
### Write model
```ruby
class Article < ApplicationRecord
  # Scope of fulltext matching
  scope :match, lambda { |text|
    jt = Gcl::FulltextSearch::JapaneseTokenizer.new
    where(arel_table[:text_for_index].match_against(jt.tokenize(text)))
  }

  # Automatically update text_for_index with tokenized string.
  before_save do
    jt = Gcl::FulltextSearch::JapaneseTokenizer.new
    self.text_for_index = jt.tokenize(title, body)
  end
end
```

### Write Controller
```ruby
class ArticlesController < ApplicationController
  def index
    @articles = Article.match(params[:keyword])
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
