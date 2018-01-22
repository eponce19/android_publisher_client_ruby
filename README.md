# Android Publisher Client API Samples

This directory is based in the samples of Google (https://github.com/google/google-api-ruby-client) and contains a simple Sinatra web app illustrating how to use the client
in a server-side web environment.

It illustrates a few key concepts:

* Using [Google Service Accounts](https://console.developers.google.com/apis/credentials) for authentication.
* Using the [androidpublisher_v2 gem](http://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/AndroidpublisherV2/AndroidPublisherService) to
  request information of Google Play Console.

# Setup

* Create a project at https://console.developers.google.com
* Go to the `API Manager` and enable the `Sub/Pub` and `Androidpublisher` APIs
* Go to `Credentials` and create a new Service Account.

Additional details on how to enable APIs and create credentials can be
found in a quick tutorial in https://stackoverflow.com/questions/48391248/which-is-the-best-way-to-make-my-rails-project-an-androidpublisher-client?noredirect=1#comment83770590_48391248.

## Example Environment Settings

For convenience, application credentials downloaded from Google Cloud Console can be placed in a key.json file in root of this project.


# Running the samples

To start the server, run

```
bundle
bundle exec rake db:migrate
ruby app.rb
```

Open `http://localhost:4567/` in your browser to explore the sample.
