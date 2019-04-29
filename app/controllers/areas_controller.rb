class AreasController < ApplicationController
  def index
    @areas = Area.using(:dwh_t).where(error: true)
  end

  def edit
    @areas = Area.using(:dwh_t).find(params[:id])
  end

  def update
    @areas = Area.using(:dwh_t).find(params[:id])

    if @areas.update(areas_params)
      flash[:notice] = 'Actualizado Correctamente'
      redirect_to areas_path
    else
      flash.now[:alert] = 'Error actualizando'
      render 'edit'
    end
  end

  def areas_params
    params.require(:area).permit(:id, :nombre, :clave)
  end

  private

end
