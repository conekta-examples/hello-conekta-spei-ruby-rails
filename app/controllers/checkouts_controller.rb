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
        details:
        {
          email: 'test@mail.com',
          line_items: [
            { name: 'Pizza at test',
              description: 'A pizza test description',
              unit_price: params['chargeInCents'],
              quantity: 1,
              sku: 'pizza-test',
              type: 'pizza'
            }
          ]
        },
        bank: {
          type: 'spei'
        }
      })
    rescue Conekta::ParameterValidationError => e
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
