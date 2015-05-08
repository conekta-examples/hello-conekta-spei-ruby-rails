## SPEI Payments with Conekta API 1.0.0 in Rails 4.1

#### This app is an example of how to create an SPEI payment using Ruby on Rails with Conekta API 1.0.0 and configure an endpoint to receive webhook notifications.

To run you need:

1. `git clone git@github.com:conekta-examples/hello-conekta-spei-ruby-rails.git`
2. run `rake secrets` and copy to `config/secrets.yml.example` and save removing `.example` extension.
3. Then you need to create a Conekta Developer account and copy and paste the keys to `config/secrets.yml`

#### Use webhooks in app.

To run webhooks in sandbox mode you'll need a third app/script to make a tunnel to your localhost or rails local server app.

You can use whatever you like to make a tunnel, in this case we gonna make an example using [ngrok](https://ngrok.com)
