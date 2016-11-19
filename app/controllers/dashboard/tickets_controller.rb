class Dashboard::TicketsController < Dashboard::BaseController
  add_breadcrumb I18n.t(:ticket).pluralize, :dashboard_tickets_path
  before_action :load_or_init_ticket, only: [:show, :destroy, :create, :edit, :update, :new]

  def index
    @q = Ticket.order('created_at asc').search(params[:q])
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
      @ticket.ticket_logs.create(action: 'Open the ticket', content: params[:ticket][:description], agent_id: current_user.id)
      flash[:success] = "#{I18n.t(:ticket)} successfully created!"
      redirect_to dashboard_tickets_path
    end
  end

  def edit
    add_breadcrumb I18n.t(:edit), :new_dashboard_ticket_path
  end

  def update
    @ticket.update_attributes(ticket_params)
    @ticket.update_column :agent_id, current_user.id

    if @ticket.invalid?
      render :edit
    else
      create_ticket_log
      # flash[:success] = "#{I18n.t(:ticket)} successfully updated!"
      redirect_to dashboard_tickets_path
    end
  end

  def destroy
    @ticket.destroy
    flash[:warning] = "<b>Ticket #{@ticket.ref_number}</b> has been deleted <span class='fa fa-trash-o'>&nbsp;</i>".html_safe
    redirect_to :back
  end

  private

  def ticket_params
    params.fetch(:ticket).permit(:title, :image, :status, :customer_phone, :customer_name, :logs, :category)
  end

  def load_or_init_ticket
    @ticket = if params[:id].present?
      Ticket.find(params[:id])
    else
      current_user.tickets.new
    end
  rescue
    raise ActionController::RoutingError, 'Product Not Found'
  end

  def create_ticket_log(action: 'Commented')
    if (content = params[:ticket][:description]).present?
      @ticket.ticket_logs.create(action: action, content: content, agent_id: current_user.id)
    end
  end
end