# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SqlMatchers do
  include SqlMatchers::Methods

  temporary_table :users
  temporary_model :user

  it 'should assert query count' do
    expect { User.count }.to match_query(count: 1)
  end

  it 'should assert query matches' do
    expect { 3.times { User.find_by(id: _1 + 1) } }.to(
      match_queries(count: 3) do |(first, second, third, *rest)|
        expect(first).to eq %(SELECT "users".* FROM "users" WHERE "users"."id" = 1 LIMIT 1)
        expect(second).to eq %(SELECT "users".* FROM "users" WHERE "users"."id" = 2 LIMIT 1)
        expect(third).to eq %(SELECT "users".* FROM "users" WHERE "users"."id" = 3 LIMIT 1)
        expect(rest).to be_empty
      end
    )
  end

  it 'should assert SQL matches' do
    expect(User.where(id: 42).to_sql).to match_sql <<~SQL.squish
      SELECT "users".* FROM "users" WHERE "users"."id" = 42
    SQL
  end
end
