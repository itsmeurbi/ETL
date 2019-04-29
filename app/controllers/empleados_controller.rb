class EmpleadosController < ApplicationController
  def index
    if current_user.admin?
      @empleados = Empleado.using(:dwh_t).where(error: true).order(:nombre)
    elsif current_user.hotel?
      @empleados = Empleado.using(:dwh_t).where(sistema: 'H', error: true).order(:nombre)
    elsif current_user.rrhh?
      @empleados = Empleado.using(:dwh_t).where(sistema: 'RR', error: true).order(:nombre)
    else
      @empleados = Empleado.using(:dwh_t).where(sistema: 'R', error: true).order(:nombre)
    end
  end

  def edit
    @empleado = Empleado.using(:dwh_t).find(params[:id])
  end

  def update
    @empleado = Empleado.using(:dwh_t).find(params[:id])
    if @empleado.update(empleado_params)
      flash[:notice] = 'Actualizado'
      redirect_to empleados_path
    else
      flash.now[:alert] = 'Error actualizando'
      render 'edit'
    end
  end

  def empleado_params
    params.require(:empleado).permit(:nombre, :f_nacimiento, :c_electronico, :n_telefono, :genero, :rfc, :baja, :sistema, :f_entrada)
  end
end
