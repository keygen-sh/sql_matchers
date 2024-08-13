# sql_matchers

[![CI](https://github.com/keygen-sh/sql_matchers/actions/workflows/test.yml/badge.svg)](https://github.com/keygen-sh/sql_matchers/actions)
[![Gem Version](https://badge.fury.io/rb/sql_matchers.svg)](https://badge.fury.io/rb/sql_matchers)

Use `sql_matchers` for query assertions and SQL matchers in RSpec.

This gem was extracted from [Keygen](https://keygen.sh).

Sponsored by:

<a href="https://keygen.sh?ref=sql_matchers">
  <div>
    <img src="https://keygen.sh/images/logo-pill.png" width="200" alt="Keygen">
  </div>
</a>

_A fair source software licensing and distribution API._

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'sql_matchers'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install sql_matchers
```

## Usage

```ruby
it 'should assert query count' do
  expect { User.find_by(id: 1) }.to match_query(count: 1)
end

it 'should assert query matches' do
  expect { 3.times { User.find_by(id: _1 + 1) } }.to(
    match_queries(count: 3) do |queries|
      first, second, third, *rest = queries

      expect(first).to eq %(SELECT "users".* FROM "users" WHERE "users"."id" = 1 LIMIT 1)
      expect(second).to eq %(SELECT "users".* FROM "users" WHERE "users"."id" = 2 LIMIT 1)
      expect(third).to eq %(SELECT "users".* FROM "users" WHERE "users"."id" = 3 LIMIT 1)
      expect(rest).to be_empty
    end
  )
end

it 'should assert SQL matches' do
  # match_sql will attempt to normalize formatting to prevent false-negatives
  expect(User.where(id: 42).to_sql).to match_sql <<~SQL.squish
    SELECT
      users.*
    FROM
      users
    WHERE
      users.id = 42
  SQL
end
```

## Future

Right now, the gem only supports RSpec, but we're open to pull requests that
extend the functionality to other testing frameworks.

## Supported Rubies

**`sql_matchers` supports Ruby 3.1 and above.** We encourage you to upgrade
if you're on an older version. Ruby 3 provides a lot of great features, like
better pattern matching and a new shorthand hash syntax.

## Is it any good?

Yes.

## Contributing

If you have an idea, or have discovered a bug, please open an issue or create a
pull request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
