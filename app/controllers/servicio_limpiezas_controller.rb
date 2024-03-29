class ServicioLimpiezasController < ApplicationController
    def index

        @serviciol = ServicioLimpieza.using(:dwh_t).where(error: true)
    end

    def edit
      @serviciol = ServicioLimpieza.using(:dwh_t).find(params[:id])
    end

    def destroy
      @serviciol = ServicioLimpieza.using(:dwh_t).find(params[:id])
      if @serviciol.destroy
        flash[:notice] = 'Eliminado'
      else
        flash[:alert] = 'Error eliminando'
      end
      redirect_to servicio_limpiezas_path
    end

    def update
      @serviciol = ServicioLimpieza.using(:dwh_t).find(params[:id])
      if validate_attributes && @serviciol.update(serviciosl_params)
        @serviciol.update_attributes(error: false)
        flash[:notice] = 'Actualizado Correctamente'
        redirect_to servicio_limpiezas_path
      else
        flash.now[:alert] = 'Error actualizando'
        render 'edit'
      end
    end

    def delete_with_errors_servicio_limpieza
      ServicioLimpieza.using(:dwh_t).where(error: true).delete_all
      redirect_to landing_page_index_path
    end 

    def serviciosl_params
      params.require(:servicio_limpieza).permit(:id, :nombre)
    end

    def validate_attributes
      valid_nombrecosas?(params[:servicio_limpieza][:nombre])
    end

end
