class LancamentoController < ApplicationController
  def index
    #@questionarios = Quiz.all
  end
  def new
    @questionario = Quiz.new
  end

  def create
    @questionario = Quiz.create(post_quiz)
    if @questionario.save
        redirect_to "/", notice: "A sua resposta, foi recebida com sucesso!"
    else
        render :new
    end

  end
  
  private
  def post_quiz
    params.require(:quiz).permit(:id, :email, :name)
    #params.require(:product).permit(:id, :image, :title, :description, :category_id, :priceof, :pricefor, :user, :situation, :company_id)
  end



end


