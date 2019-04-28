class AsignacionMaterialesController < ApplicationController
    def index
        initialize_mgh
        @asignacionm = AsignacionMaterial.using(:dwh_t).all
    end

    def edit
      @asignacionm = AsignacionMaterial.using(:dwh_t).find(params[:id])
    end

    def update
      @asignacionm = AsignacionMaterial.using(:dwh_t).find(params[:id])

      if @asignacionm.update(asignacion_params)
        flash[:notice] = 'Actualizado Correctamente'
        redirect_to asignacion_materiales_path
      else
        flash[:alert] = 'Error actualizando'
        render 'edit'
      end
    end

    def asignacion_params
      params.require(:asignacion_material).permit(:id, :idAsignacion, :Cantidad, :idHabitacion, :idMaterial)
    end

  private

  def initialize_mgh
    AsignacionMaterial.using(:dwh_t).delete_all

    materiales = AsignacionMaterial.using(:restaurant).all
    material = AsignacionMaterial.using(:dwh_t).new()


    materiales.each do |se|
      material = AsignacionMaterial.using(:dwh_t).new()

      material.id = se.idAsignacion
      material.cantidad = se.Cantidad
      material.id_habitacion = se.idHabitacion
      material.id_material = se.idMaterial
      material.save!
    end
  end
end