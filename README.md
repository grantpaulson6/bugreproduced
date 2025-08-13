# README

This repo is used to reproduce errors in activerecord-cockroachdb-adapter. 

To reproduce using this repo, update the database.yml with your CRDB cluster info. You will need a console user for your CRDB cluster.
Then run some setup commands:

```
bundle install
bundle exec rails db:create db:migrate
```

then the following in the rails console to trigger the error:

```
parsed = YAML.safe_load(Post.comment, permitted_classes: [Symbol, Regexp]) # successfully parses
comment = ActiveRecord::Base.connection.columns(:posts).find { |c| c.name.to_s == 'some_info' }.comment
parsed = YAML.safe_load(comment, permitted_classes: [Symbol, Regexp]) # errors out
```

