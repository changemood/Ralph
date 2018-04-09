class Api::V1::BoardsController < Api::V1::BaseController  
  before_action :set_resources, only: [:index]  
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  
  # GET /api/v1/boards
  # GET /api/v1/boards.json
  def index
    render :index, status: :ok
  end

  # GET /api/v1/boards/1
  # GET /api/v1/boards/1.json
  def show
    render :show, status: :ok    
  end

  # POST /api/v1/boards
  # POST /api/v1/boards.json
  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      render :show, status: :created
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/boards/1
  # PATCH/PUT /api/v1/boards/1.json
  def update
    if @board.update(board_params)
      render :show, status: :ok
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/boards/1
  # DELETE /api/v1/boards/1.json
  def destroy
    if @board.update!(deleted_at: Time.now)
      destroy_cards
      head :no_content
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resources
      @boards = Board.where(user: current_user)
    end

    def set_resource
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name)
    end

    # update all dependent cards if board is destroyed(update deleted_at)
    def destroy_cards
      Card.where(board: @board).update_all(deleted_at: Time.now)
    end
  
end
