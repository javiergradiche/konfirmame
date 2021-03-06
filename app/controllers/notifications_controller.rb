class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy, :open, :confirm, :reject, :pospose]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @notification }
      else
        format.html { render action: 'new' }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end

  def send_shippeables
    if (params[:datetime])
      datetime = params[:datetime].to_datetime
    else
      datetime = Time.now
    end
    @notifications = Notification.get_shippables(datetime)
    Notification.send_shippable_package(@notifications)
  end

  def open
    @event_occurrence = @notification.event_occurrence
    @notification.update_state!(NotificationStatusOpened.new)
    render 'event_occurrences/stats'
  end

  def reject
    @event_occurrence = @notification.event_occurrence
    @notification.update_state!(NotificationStatusRejected.new)
    render 'event_occurrences/stats'
  end

  def confirm
    @event_occurrence = @notification.event_occurrence
    if @event_occurrence.full?
      @notification.update_state!(NotificationStatusDenied.new)
    else
      @notification.update_state!(NotificationStatusConfirmed.new)
    end
    render 'event_occurrences/stats'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:event_id, :occurrence_id, :user_id, :status, :comment)
    end
end
