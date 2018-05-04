class Api::V1::CardsController < Api::V1::BaseController
  before_action :set_resource, only: [:show, :update, :destroy, :update_ancestry]
  before_action :set_resources, only: [:index, :create, :review_cards]

  # GET /api/v1/cards
  # GET /api/v1/cards.json
  def index
    render :index, status: :ok
  end

  # GET /api/v1/cards/1
  # GET /api/v1/cards/1.json
  def show
    render :show, status: :ok    
  end

  # POST /api/v1/cards
  # POST /api/v1/cards.json
  def create
    @card = @cards.new(card_params)
    if @card.save
      params[:interval] ? @card.add_sr_event(params[:interval].to_i) : @card.add_sr_event
      render :show, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/cards/1
  # PATCH/PUT /api/v1/cards/1.json
  def update
    if @card.update(card_params)
      render :show, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/cards/1
  # PATCH/PUT /api/v1/cards/1.json
  def update_ancestry
    if @card.update(parent: Card.find(card_update_ancestry_params))
      render :show, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/cards/1
  # DELETE /api/v1/cards/1.json
  def destroy
    @card.update!(deleted_at: Time.now)
    head :no_content
  end

  # GET /api/v1/cards/review_cards.json
  def review_cards
    @review_cards = @cards.review_cards
    render :review_cards, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @card = Card.find(params[:id])
    end

    def set_resources
      if params[:board_id]
        @cards = Board.find(params[:board_id]).cards
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
