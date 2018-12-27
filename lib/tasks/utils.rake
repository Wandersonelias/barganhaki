require 'mercadopago.rb'

namespace :utils do
  desc "Teste mercadopago"
  task mercadopago: :environment do
    mp = MercadoPago.new('701050300068006','xtJORqNdum0sl1AGV7lS1kiAPEFyQ1WD')


    preference_data = {
			"items": [
				{
					"title": "Caixa de presente", 
					"quantity": 1, 
					"unit_price": 10.2, 
					"currency_id": "BRL"
				}
			]
		}
    preference = mp.create_preference(preference_data)

    debugger

    preference = mp.get_preference('PREFERENCE_ID')

    x = "ssss"
  end
end
