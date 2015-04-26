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
    # gcm_ids = V1::Device
    #   .select('gcm_registration_id')
    #   .joins(:seller)
    #   .where(v1_sellers: { id: quote.seller_ids })
    #   .map(&:gcm_registration_id)
    # if gcm_ids.any? # throws a Registration ids can't be blank error otherwise
    #   notifiction = Rpush::Gcm::Notification.new
    #   notifiction.app = instano_buyer_gcm_app
    #   notifiction.registration_ids = gcm_ids
    #   notifiction.data = {
    #     type: 'quote',
    #     quote: quote
    #   }
    #   notifiction.save!
    # end
  end

  def GcmNotifier.quotation_updated(quotation)
    gcm_ids = []

    if quotation.product
      gcm_ids << V1::Device.where(id: V1::Buyer.where(id: quotation.product.quotes))
                      .select('gcm_registration_id')
                      .map(&:gcm_registration_id)
    end

    if gcm_ids.any? # throws a Registration ids can't be blank error otherwise
      notifiction = Rpush::Gcm::Notification.new
      notifiction.app = instano_buyer_gcm_app
      notifiction.registration_ids = gcm_ids
      notifiction.data = {
        type: 'quotation',
        quotation: quotation
      }
      notifiction.save!
    end
  end

  def GcmNotifier.seller_updated(seller)
    gcm_ids = V1::Device
        .select('gcm_registration_id')
        .joins(:buyer)
        .map(&:gcm_registration_id)

    if gcm_ids.any? # throws a Registration ids can't be blank error otherwise
      notifiction = Rpush::Gcm::Notification.new
      notifiction.app = instano_buyer_gcm_app
      notifiction.registration_ids = gcm_ids
      notifiction.data = {
          type: 'seller',
          seller: V1::SellerSerializer.new(seller)
      }
      notifiction.save!
    end
  end
end
