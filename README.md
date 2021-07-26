# Velocity

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:3000`](http://localhost:3000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

# Docker

You can run the tool by using the provided Dockerfile

  * build the image using `docker build -t velocity .`
  * provide an docker.env file containing 3 different environment-variables:
    * JIRA_AUTH_TOKEN // base64-encoded jira-login (username:password)
    * ABSENCE_IO_ID
    * ABSENCE_IO_KEY
  * run the container using `docker run -p 3000:3000 --env-file docker.env velocity`