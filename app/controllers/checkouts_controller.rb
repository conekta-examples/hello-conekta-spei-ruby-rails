class CheckoutsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:webhook]
  def index
  end

  def charge
    begin
      @charge = Conekta::Charge.create({
        amount: params['chargeInCents'],
        currency: "MXN",
        description: "Pizza Delivery at test",
        reference_id: "001-id-test",
        cash: {
          type: 'oxxo'
        }
      })
    rescue Conekta::ValidationError => e
      puts e.message_to_purchaser
      #alguno de los parámetros fueron inválidos
    rescue Conekta::ProcessingError => e
      puts e.message_to_purchaser
      #la tarjeta no pudo ser procesada
    rescue Conekta::Error
      puts e.message_to_purchaser
      #un error ocurrió que no sucede en el flujo normal de cobros como por ejemplo un auth_key incorrecto
    end
  end

  def webhook
    #get info from params
    begin
      object_type= params["data"]["object"]["object"]
      object_id = params["data"]["object"]["id"]
      webhook_type = params['type']
      puts "object_type: #{object_type}, id: #{object_id}, type: #{webhook_type}"
      head 200, content_type: "text/html"
    rescue
      puts "something went wrong with our params"
      head 200, content_type: "text/html"
    end
  end
end
