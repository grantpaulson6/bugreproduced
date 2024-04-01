# README

This repo is used to reproduce an error in activerecord-cockroachdb-adapter. Essentially, with the rails 7.1 upgrade
of the gem, when the first query run starts a transaction (like `create_or_find_by`), the as of system time type introspection
queries occur after the transaction starts, and throw a CRDB error `PG::FeatureNotSupported: ERROR:  inconsistent AS OF SYSTEM TIME timestamp`

More [in the github issue](https://github.com/cockroachdb/activerecord-cockroachdb-adapter/issues/320)

To reproduce using this repo, update the database.yml with your CRDB cluster info. You will need a console user for your CRDB cluster.
Then run some setup commands:

```
bundle install
bundle exec rails db:create db:migrate
```

then the following in the rails console to trigger the error:

```
Post.create_or_find_by!(other_id: '123')
```

To get additional logging, you can add this in first:

```
class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
  def log(sql, name = "SQL", binds = [], type_casted_binds = [], statement_name = nil, async: false, &block)
    puts "------ #{name&.chomp || "anonymous query"} ------\n-- \n#{sql.chomp};\n\n"
    lines = caller_locations
    lines.each { |line| puts line }
    super
  end
end
```

