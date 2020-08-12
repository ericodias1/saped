class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new state: 'pending'
  end

  def create
    @order = Order.new order_params
    @order.state = 'pending'

    if @order.save
      flash[:success] = 'Pedido criado com sucesso.'
      redirect_to orders_path
    else
      flash.now[:danger] = 'Falha ao criar o pedido.'
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = 'Pedido criado com sucesso.'
      redirect_to orders_path
    else
      flash[:danger] = 'Falha ao criar o pedido.'
      render :new
    end
  end

  def destroy
    if @order.state == 'pending' && @order.destroy
      flash[:success] = 'Pedido excluído com sucesso.'
    else
      flash[:danger] = 'Erro ao excluir o pedido. Não é possível excluir pedidos concluídos ou em andamento.'
    end
    redirect_to orders_path
  end

  private
    def order_params
      params.require(:order).permit(:name, :order_number)
    end

    def set_order
      @order = Order.find(params[:id])
    end
end
