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
              debugger
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

        Iugu.api_key = "a47a7e30aa6a12e8603a7d5452fe5e27"
        payment_method = nil
        
        customer = Iugu::Customer.create({
          email: current_user.email,
          name: current_user.name,
          notes: "Cartão para ser usado em compras barganhaki, email #{current_user.email}"
        })
        
        payment_method = customer.payment_methods.create({
          description: "Cartão #{current_user.name} - #{current_user.email}",
          token: token
        })

        itens = []
        dados = JSON.parse(cookies["carrinho"]) #recebe o cookie de "Carrinho"
        dados.each do |product_hash| #percorre o array carrinho pegando o id dos produtos
          product = Product.find(product_hash["id"]) 
          valor = product.pricefor
          valor_centavos = (valor * 100).to_i
          itens << [
            {
              "description" => product.description,
              "quantity" => product_hash["quantidade"],
              "price_cents" => valor_centavos
            }
          ]
        end
        options = {
          "email"=> current_user.email,
          "months"=> 1, # quantidade de parcelas
          "items" => itens
        }
        
        options["customer_payment_method_id"] = payment_method.id
        
        payment_retorn = Iugu::Charge.create(options)
        
        if payment_retorn.errors.present?
          begin
            mensagem = payment_retorn.errors.map{|k,v| "#{k}: #{v.join(",")}"}.join(", ")
          rescue
            mensagem = payment_retorn.errors.inspect rescue "Erro ao fazer pagamento, tente novamente mais tarde"
          end
          raise mensagem
        else
          if payment_retorn.respond_to?(:LR)
            if payment_retorn.LR != "00"
              raise payment_retorn.message
            end
          else
            if payment_retorn.respond_to?(:identification) &&  payment_retorn.respond_to?(:success) && payment_retorn.success
              return true
            else
              raise payment_retorn.message
            end
          end
        end
        #caputura o 
        @order.invoice_id = payment_retorn.invoice_id
        #envio sms

        
        return true
        
    end

end
