class CustomersController < ApplicationController
  before_action :logged_in_user

  def initialize
    super
    @resource = "Customers"
  end

  # CREATE
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = "Created customer"
      redirect_to @customer
    else
      render :new
    end
  end

  def new
    @customer = Customer.new if @customer == nil
  end

  # READ
    def show
    @customer = Customer.find(params[:id])
    @projects = @customer.projects
  end

  def index
    @customers = Customer.all
  end
  
  # UPDATE
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:success] = "Updated customer"
      redirect_to @customer
    else
      render 'edit'
    end
  end

  # DESTROY
  def destroy
    Customer.find(params[:id]).destroy
    flash[:success] = "Deleted customer"
    redirect_to customers_url
  end

  private
    def customer_params
      params.require(:customer).permit(:company, :address, :city, :state, :zip)
    end
end