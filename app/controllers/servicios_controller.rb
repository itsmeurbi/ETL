class ServiciosController < ApplicationController
    def index
        initialize_servicios
        @servicio = Servicio.using(:dwh_t).all
    end
    def edit
      @servicio = Servicio.using(:dwh_t).find(params[:id]) 
    end

    def update
      @servicio = Servicio.using(:dwh_t).find(params[:id])

      if @servicio.update(servicios_params)
        flash[:notice] = 'Actualizado Correctamente'
        redirect_to servicios_path
      else 
        flash[:alert] = 'Error actualizando'
        render 'edit'
      end
    end

    def servicios_params
      params.require(:servicio).permit(:id, :idServicio, :Nombre)
    end
    
 private
    def initialize_servicios
        Servicio.using(:dwh_t).delete_all
    
        servicios_h = Servicio.using(:restaurant).all
        servicio_t = Servicio.using(:dwh_t).new()
    
    
        servicios_h.each do |s|
          servicio_t = Servicio.using(:dwh_t).new()
          servicio_t.idServicio = s.idServicio
          servicio_t.Nombre = s.Nombre
          servicio_t.save!
        end
      end
end