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
found in the tutorial in .. (LINK Coming Soon).

## Example Environment Settings

For convenience, application credentials can be placed in a .json file in root of this project.


# Running the samples

To start the server, run

```
ruby app.rb
```

Open `http://localhost:4567/` in your browser to explore the sample.
