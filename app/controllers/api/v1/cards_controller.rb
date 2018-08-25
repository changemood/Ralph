class Api::V1::CardsController < Api::V1::BaseController
  before_action :set_resource, only: [:show, :update, :destroy, :update_ancestry, :up, :down]
  before_action :set_resources, only: [:index, :create, :review_cards, :tree]

  # GET /v1/cards
  # GET /v1/cards.json
  def index
    # TODO: pagination
    @cards = @cards.order('created_at desc')
    render json: @cards, status: :ok
  end

  # GET /v1/boards/xxxx/tree.json
  # We expect to call this with board id...
  def tree
    @roots = @cards.roots
    # TODO: remove jbuilder?
    render :tree, status: :ok
  end

  # GET /v1/cards/1
  # GET /v1/cards/1.json
  def show
    render json: @card, status: :ok
  end

  # POST /v1/cards
  # POST /v1/cards.json
  def create
    @card = @cards.new(card_params)
    @card.assign_attributes(parent: Card.find_by_id(params[:card][:parent_id])) if params[:card][:parent_id]
    if @card.save
      @card.add_sr_event(1)
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/cards/1
  # PATCH/PUT /v1/cards/1.json
  def update
    if @card.update(card_params)
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/cards/1/update_ancestry.json
  def update_ancestry
    if @card.update(parent: Card.find_by_id(params[:parent_id]))
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/cards/1
  # DELETE /v1/cards/1.json
  def destroy
    @card.update!(deleted_at: Time.now)
    head :no_content
  end

  # GET /v1/cards/review_cards.json
  def review_cards
    @review_cards = @cards.review_cards
    render json: @review_cards, status: :ok
  end

  # POST: /v1/cards/up.json
  def up
    if @card.up!
      render json: @card, status: :ok
    else
      raise "THIS CARD IS NOT READY"
    end
  end

  # POST: /v1/cards/down.json
  def down
    if @card.down!
      render json: @card, status: :ok
    else
      raise "THIS CARD IS NOT READY"
    end
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
end
