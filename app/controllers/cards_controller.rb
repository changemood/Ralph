class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :update_ancestry]
  before_action :set_resources, only: [:index, :new]

  # GET /cards
  # GET /cards.json
  def index
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        @card.add_sr_event(1)
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update_ancestry
    respond_to do |format|
      if @card.update(parent: Card.find(card_update_ancestry_params))
        format.html { redirect_to @card, notice: 'Ancestry was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.update!(deleted_at: Time.now)
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @card = Card.find(params[:id])
    end

    def set_resources
      if params[:board_id]
        @board = Board.find(params[:board_id])
        @cards = @board.cards
      else
        @cards = current_user.cards
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:title, :body, :board_id, :user_id)
    end

    def card_update_ancestry_params
      params.require(:parent_id)
    end
end
