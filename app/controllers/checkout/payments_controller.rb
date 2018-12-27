class Checkout::PaymentsController < ApplicationController
    before_action :authenticate_user! 
    skip_before_action :verify_authenticity_token, only: [:formapagamento]
    
    
    layout "profile"
    def index
        require 'rqrcode_png'
        @orders = Order.all
        @company = Company.all
      
      #  qrcode = RQRCode::QRCode.new(item.cupom.to_s)
			#	qrcode.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 5).html_safe    
             
    end
    def listar
      require 'rqrcode_png'
      @orders = Order.all
      @company = Company.all
    
      #  qrcode = RQRCode::QRCode.new(item.cupom.to_s)
      #	qrcode.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 5).html_safe    
           
    end
    
    def formapagamento
      pagseguro_session = PagSeguro::Session.new
      @session_id = pagseguro_session.create.id

      carrinho = JSON.parse(cookies["carrinho"]) #recebe o cookie de "Carrinho"
      carrinho.each do |product| #percorre o array carrinho pegando o id dos produtos
        params["produto_ids"].each_with_index do |id, index|
          if product["id"] == id
            product["quantidade"] = params["quantidade"][index]
            break
          end
        end
      end

      cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true }
    end

    def create
        unless user_signed_in? 
            redirect_to "/users/sign_in"
            return
        end

        if cookies["carrinho"].present? #metodo de pergunta - verifca se ha items no carrinho
          @order = Order.new
          if pagamento_confirmado? 
            @order.user_id = current_user.id # faz ajuncao entre a order e o usuario atual
            @order.save! #salva a ordem
            dados = JSON.parse(cookies["carrinho"]) #recebe o cookie de "Carrinho"
            dados.each do |product_hash| #percorre o array carrinho pegando o id dos produtos
                product = Product.find(product_hash["id"]) #seta o produto de axirdo com o seu id
                item = OrderItem.new #Cria um novo item
                item.product = product #vincula um item a um produto
                item.order = @order # vincula o item que ja esta vinculado a um produto e  vincula com uma order
                item.value = product.pricefor #o campo valuue recebe o valor do produto
                item.quantity = product_hash["quantidade"] # quantidade default e 1
                item.cupom = item.gera_cupom
                item.save! #metodo bang
            end
            cookies.delete("carrinho") #quando finalizar deletar do cookies do carrinho
          end
        end
        redirect_to "/checkout/payments" #criar pagina de finalização de compra
    end
   
    def pagamento_confirmado?
        token = params[:token_id]

        payment = PagSeguro::Payment.new(notification_url: 'www.eventick.com.br/notify', payment_method: 'creditCard', reference: '1')

        payment.reference = 12345

        itens = []
        dados = JSON.parse(cookies["carrinho"]) #recebe o cookie de "Carrinho"
        dados.each do |product_hash| #percorre o array carrinho pegando o id dos produtos
          product = Product.find(product_hash["id"]) 
          payment.items << PagSeguro::Item.new(
            id: product.id,
            description: product.description,
            amount: product.pricefor,
            quantity: product_hash["quantidade"]
          )
        end




        #====== versão antiga da api ======#
        phone = PagSeguro::Phone.new('11', '999999999')
        document = PagSeguro::Document.new('92871399204')
        sender = PagSeguro::Sender.new(email: 'cirdes@eventick.com.br', name: 'Cirdes Henrique', hash_id: 1234 )
        sender.phone = phone
        sender.document = document
        payment.sender = sender
        address = PagSeguro::Address.new(postal_code: '01318002', street: 'AV BRIGADEIRO LUIS ANTONIO', number: '1892', complement: '112', district: 'Bela Vista', city: 'São Paulo', state: 'SP')
        credit_card = PagSeguro::CreditCard.new(token)
        credit_card.installment = PagSeguro::Installment.new(installment_quantity, installment_value) #verificar essas informações
        credit_card.holder = PagSeguro::Holder.new('Cirdes Henrique', '04/2019')
        credit_card.billing_address = address
        payment.credit_card = credit_card

        transaction = payment.transaction

        if transaction.errors.length > 0
          raise transaction.errors[0]["message"]
        end

        return true
        
    end

end
