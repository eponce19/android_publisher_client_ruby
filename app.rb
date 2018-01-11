
require 'sinatra'
require 'google/apis/androidpublisher_v2'
require 'dotenv'
require "sinatra/activerecord"

autoload :Notification, File.join(File.dirname(__FILE__),'models','notification')
autoload :ServiceToken, File.join(File.dirname(__FILE__),'models','service_token')


LOGIN_URL = '/'

configure do
  Dotenv.load
  enable :sessions
  set :show_exceptions, true
  set :database, {adapter: "sqlite3", database: "androidpublisherclient.sqlite3"}
  set :public_folder, 'public'
  set :pub, ''
end

helpers do

  # Returns credentials authorized for the requested scopes.
  def credentials_for(scopes)
    authorization = Google::Auth.get_application_default(scopes)
    settings.pub = Google::Apis::AndroidpublisherV2::AndroidPublisherService.new
    settings.pub.authorization = authorization
    auth_token = settings.pub.authorization.fetch_access_token!
    st = ServiceToken.find_or_create_by(id:1)
    st.token = auth_token["access_token"]
    st.token_created_at = Time.now
    st.token_expire_at = Time.now + auth_token["expires_in"].to_i
    st.save
  end

  def token_for_publisher
    st = ServiceToken.first
    token_expire = st ? st.token_expire_at : Time.now
    scopes = Google::Apis::AndroidpublisherV2::AUTH_ANDROIDPUBLISHER
    st =
    if settings.pub.blank? || token_expire <= Time.now
      credentials_for(scopes)
    end
    settings.pub
  end

end


# Home page
get('/') do
  erb :home
end

#webhook
post('/webhook') do
    request.body.rewind
    data = JSON.parse(request.body.read)["message"]["data"]
    notif_params = JSON.parse(Base64.decode64(data))
    notification = Notification.create(
      package_name: notif_params["packageName"],
      notification_params:notif_params,
      sku: notif_params["subscriptionId"],
      event_time: Time.at( notif_params["eventTimeMillis"].to_i / 1000 )
    )

    #FOR RAILS
    # if request.headers['Content-Type'] == 'application/json'
    #   data = JSON.parse(request.body.read)["message"]["data"]
    #   decode_base64_content = Base64.decode64(data)
    #   @notification = Notification.create(notification_params:decode_base64_content)
    # else
    #   data = params.as_json
    #   @notification = Notification.create(notification_params:data)
    # end
    # render nothing: true
end

get('/android_publisher') do
  erb :publisher
end

post('/search_api_google') do
  token_for_publisher
  sku = params[:sku]
  package = params[:package]
  token = params[:token]
  begin
    @product_info = settings.pub.get_in_app_product(package, sku)
    if !token.blank?
      @product_purchase = settings.pub.get_purchase_subscription(package,sku,token)
    end
  rescue Google::Apis::ClientError
    @error = "Please verify your values (sku, package or token)"
  rescue Google::Apis::AuthorizationError
    @error = "You don't have the authorization to see this information"
  end
  erb :publisher
end

get('/notifications') do
    @notifications = Notification.all
    erb :'notifications/index'
end
