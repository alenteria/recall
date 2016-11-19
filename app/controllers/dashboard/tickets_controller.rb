class Dashboard::TicketsController < Dashboard::BaseController
  add_breadcrumb I18n.t(:ticket).pluralize, :dashboard_tickets_path
  before_action :load_or_init_ticket, only: [:show, :destroy, :create, :edit, :update, :new]

  def index
    @q = current_user.tickets.order('created_at asc').search(params[:q])
    @tickets = @q.result.paginate(:page => params[:page])
  end

  def new
    add_breadcrumb I18n.t(:new), :new_dashboard_ticket_path
  end

  def create
    @ticket.assign_attributes(ticket_params)
    @ticket.save
    unless @ticket.persisted?
      render :new
    else
      flash[:success] = "#{I18n.t(:ticket)} successfully created!"
      redirect_to dashboard_tickets_path
    end
  end

  def edit
    add_breadcrumb I18n.t(:edit), :new_dashboard_ticket_path
  end

  def update
    @ticket.update_attributes(ticket_params)
    if @ticket.invalid?
      render :edit
    else
      flash[:success] = "#{I18n.t(:ticket)} successfully updated!"
      redirect_to dashboard_tickets_path
    end
  end

  def destroy
    @ticket.destroy
    flash[:warning] = "<b>#{@ticket.title}</b> has been deleted <span class='fa fa-trash-o'>&nbsp;</i>".html_safe
    redirect_to :back
  end

  private

  def ticket_params
    params.fetch(:ticket).permit(:title, :description, :image, :status, :customer_phone, :customer_name)
  end

  def load_or_init_ticket
    @ticket = if params[:id].present?
      current_user.tickets.find(params[:id])
    else
      current_user.tickets.new
    end
  rescue
    raise ActionController::RoutingError, 'Product Not Found'
  end
end