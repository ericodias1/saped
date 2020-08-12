class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, except: [:index, :new, :create]

  def index
    @q = Order.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @orders = @q.result.paginate(page: params[:page], per_page: 30)
  end

  def new
    @order = Order.new
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

  def to_in_progress
    @order.do!
    flash[:success] = 'Status do pedido alterado para Em progresso.'
    redirect_to orders_path
  end

  def to_finished
    @order.finish!
    flash[:success] = 'Status do pedido alterado para Concluído.'
    redirect_to orders_path
  end

  private
    def order_params
      params.require(:order).permit(:name, :order_number)
    end

    def set_order
      @order = Order.find(params[:id] || params[:order_id])
    end
end
