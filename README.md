# Dash

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Export `ADMIN_PATH` env variable, be sure this is unique and secure, since
     this will take you to the admin area of the blog
  4. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
To get to the admin area, visit [`localhost:4000/ADMIN_PATH/posts`](http://localhost:4000/ADMIN_PATH/posts) from your browser where `ADMIN_POST` is what you set in your env variable.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## License
Copyright 2017 michelada.io
See LICENCE
