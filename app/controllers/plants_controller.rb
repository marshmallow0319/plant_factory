class PlantsController < ApplicationController
  before_action :set_plant, only: [:show, :update, :destroy]

  # GET /plants
  def index
    @plants = Plant.all

    render json: @plants
  end

  # GET /plants/1
  def show
    message =
      case @plant.water
      when -(Float::INFINITY)..0 then "もっと水が飲みたいよ。。"
      when 1..3                  then "水飲みたいなー"
      when 4..6                  then "一口だけ水欲しい"
      else                            "今は水足りてるよ！"
      end
    render json: { "名前": @plant.name, "大きさ": "#{@plant.height}cm", "状態": message }
  end

  # POST /plants
  def create
    @plant = Plant.new(plant_params)

    if @plant.save
      render json: @plant, status: :created, location: @plant
    else
      render json: @plant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /plants/1
  def update
    if @plant.update(plant_params)
      render json: @plant
    else
      render json: @plant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /plants/1
  def destroy
    @plant.destroy
  end

  # PUT /plants/1/water
  def water
    @plant.grow(params.fetch(:water, {}))

    if @plant.save
      render json: { "名前": @plant.name, "大きさ": "#{@plant.height}cm", "水分量": @plant.water }
    else
      render json: @plant.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plant
      @plant = Plant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def plant_params
      params.fetch(:plant, {}).permit(:name)
    end
end
