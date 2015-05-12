module GcmNotifier

  def GcmNotifier.instano_buyer_gcm_app
    app = Rpush::Gcm::App.find_by(name: "com.instano.buyer")
    if app.nil?
      app = Rpush::Gcm::App.new
      app.name = "com.instano.buyer"
      app.auth_key = "AIzaSyDmnplvDn5Lpz88ovLLH3rYvXyOgR53O_I"
      app.connections = 1
      app.save!
    end
    return app
  end

  def GcmNotifier.quote_updated(quote)
    # TODO:
    gcm_ids = V1::Device
      .select('gcm_registration_id')
      .joins(:seller)
      .map(&:gcm_registration_id)
    if gcm_ids.any? # throws a Registration ids can't be blank error otherwise
      notification = Rpush::Gcm::Notification.new
      notification.app = instano_buyer_gcm_app
      notification.registration_ids = gcm_ids
      notification.data = {
        type: 'quote',
        quote: quote
      }
      notification.save!
    end
  end

  def GcmNotifier.quotation_updated(quotation)

    if quotation.product
      gcm_ids = V1::Device.where(buyer_id: V1::Quote.where(
                                     product: quotation.product)
                                         .select(:buyer_id).uniq)
                    .select('gcm_registration_id')
                    .map(&:gcm_registration_id)
      puts "gcm_ids: #{gcm_ids}"
      if gcm_ids.any? # throws a Registration ids can't be blank error otherwise
        notification = Rpush::Gcm::Notification.new
        notification.app = instano_buyer_gcm_app
        notification.registration_ids = gcm_ids
        notification.data = {
            type: 'quotation',
            quotation: quotation,
            product_name: "#{quotation.product.name}"
        }
        notification.save!
      end
    end
  end

  def GcmNotifier.seller_updated(seller)
    gcm_ids = V1::Device
        .select('gcm_registration_id')
        .joins(:buyer)
        .map(&:gcm_registration_id)

    if gcm_ids.any? # throws a Registration ids can't be blank error otherwise
      notification = Rpush::Gcm::Notification.new
      notification.app = instano_buyer_gcm_app
      notification.registration_ids = gcm_ids
      notification.data = {
          type: 'seller',
          seller: V1::SellerSerializer.new(seller)
      }
      notification.save!
    end
  end
end
