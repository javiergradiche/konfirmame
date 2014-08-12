class EventOccurrencesController < ApplicationController
  before_action :set_occurrence, only: [:show, :edit, :update, :destroy]

  # GET /event_occurrences
  # GET /event_occurrences.json
  def index
    @event_occurrences = EventOccurrence.all
  end

  # GET /event_occurrences/1
  # GET /event_occurrences/1.json
  def show
  end

  # GET /event_occurrences/new
  def new
    @event_occurrence = EventOccurrence.new
  end

  # GET /event_occurrences/1/edit
  def edit
  end

  # POST /event_occurrences
  # POST /event_occurrences.json
  def create
    @event_occurrence = EventOccurrence.new(occurrence_params)

    respond_to do |format|
      if @event_occurrence.save
        format.html { redirect_to @event_occurrence, notice: 'Occurrence was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event_occurrence }
      else
        format.html { render action: 'new' }
        format.json { render json: @event_occurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_occurrences/1
  # PATCH/PUT /event_occurrences/1.json
  def update
    respond_to do |format|
      if @event_occurrence.update(occurrence_params)
        format.html { redirect_to @event_occurrence, notice: 'Occurrence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event_occurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_occurrences/1
  # DELETE /event_occurrences/1.json
  def destroy
    @event_occurrence.destroy
    respond_to do |format|
      format.html { redirect_to occurrences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occurrence
      @event_occurrence = EventOccurrence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def occurrence_params
      params.require(:occurrence).permit(:event_id, :when, :state, :aforo, :confirmations)
    end
end
