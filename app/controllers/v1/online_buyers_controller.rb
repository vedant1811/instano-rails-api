require 'net/http'
require 'builder'
class V1::OnlineBuyersController < V1::ApiBaseController

  skip_before_filter :verify_authenticity_token

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

#   # GET /v1/online_buyers
#   # GET /v1/online_buyers.json
#   def index
#     @v1_online_buyers = V1::OnlineBuyer.all
#
#     render json: @v1_online_buyers
#   end
#
#   # GET /v1/online_buyers/1
#   # GET /v1/online_buyers/1.json
#   def show
#     @v1_online_buyer = V1::OnlineBuyer.find(params[:id])
#
#     render json: @v1_online_buyer
#   end
#
#   def exists
#     render json: { exists: V1::OnlineBuyer.exists?(:phone => params.require(:phone)) }
#   end

  # POST /v1/online_buyers
  # POST /v1/online_buyers.json
  def create

    phone = online_buyer_params[:name]
    username = "user_#{phone}"

    # create a xmpp user (or receive an error of it already existing)

    uri = URI.parse('http://xmpp-server.instano.in:9090/plugins/userService/users')

    xmlData = ''

    xmlBuilder = Builder::XmlMarkup.new(:target => xmlData)
    xmlBuilder.instruct! :xml,  :version => "1.0", :encoding => "UTF-8", :standalone => "yes"
    xmlBuilder.user do |user|
      user.username username
      user.password 'hello123'
    end

    http = Net::HTTP.new(uri.host, uri.port)
#     request = http.post('/plugins/userService/users', xmlData, {'Authorization' => '5AR3txuW', 'Content-Type' => 'application/xml'})
    request = Net::HTTP::Post.new('/plugins/userService/users')
    request.add_field('Authorization', '5AR3txuW')
    request.add_field('Content-Type', 'application/xml')
    request.body = xmlData
    response = http.request(request)


    # now save in our db
    @v1_online_buyer = V1::OnlineBuyer.new(online_buyer_params)
    if @v1_online_buyer.save
      render json: @v1_online_buyer, status: :created
    else
      render json: @v1_online_buyer.errors, status: :ok
    end
  end

#   # PATCH/PUT /v1/online_buyers/1
#   # PATCH/PUT /v1/online_buyers/1.json
#   def update
#     @v1_online_buyer = V1::OnlineBuyer.find(params[:id])
#
#     if @v1_online_buyer.update(params[:v1_buyer])
#       head :no_content
#     else
#       render json: @v1_online_buyer.errors, status: :ok
#     end
#   end
#
#   # DELETE /v1/online_buyers/1
#   # DELETE /v1/online_buyers/1.json
#   def destroy
#     @v1_online_buyer = V1::OnlineBuyer.find(params[:id])
#     @v1_online_buyer.destroy
#
#     head :no_content
#   end

  private
  def allowed_hosts
    if Rails.env.production?
      return 'http://www.91mobiles.com'
    else
      return 'http://127.0.0.1:3000'
    end
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = allowed_hosts
    headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = allowed_hosts
      headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

  def online_buyer_params
    params.require(:online_buyer).permit(:jid, :name, :phone, :url, :message)
  end
end
