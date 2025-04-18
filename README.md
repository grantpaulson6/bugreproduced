# README

This repo is used to reproduce an error in activerecord-cockroachdb-adapter. 

To reproduce using this repo, update the database.yml with your CRDB cluster info. You will need a console user for your CRDB cluster.

Additionally, ensure you cockroachdb cluster is on version 24.2 or later

Then try to migrate:

```
bundle install
bundle exec rails db:create db:migrate
```

This will generate an error

```
StandardError: An error has occurred, all later migrations canceled: (StandardError)

No indexes found on posts with the options provided.
/Users/grant.paulson/src/bugreproduced/db/migrate/20250418172325_remove_index.rb:3:in `change'

Caused by:
ArgumentError: No indexes found on posts with the options provided. (ArgumentError)

            raise ArgumentError, "No indexes found on #{table_name} with the options provided."
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/Users/grant.paulson/src/bugreproduced/db/migrate/20250418172325_remove_index.rb:3:in `change'

```

The cause is that the crdb_region column is now being returned by the cluster. This can be checked by running

```ruby
ActiveRecord::Base.connection.indexes(:posts)
```
and observing `crdb_region` is now a column listed, even though it should be hidden

You can point to an older cockroachdb cluster and observe this error does not occur
