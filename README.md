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
Copyright 2015 Michelada.io

Licensed under the MIT License (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at

  https://opensource.org/licenses/MIT

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.
