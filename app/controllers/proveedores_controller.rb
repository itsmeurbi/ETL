class ProveedoresController < ApplicationController
  def index
    if current_user.restaurant?
      @proveedores = Proveedor.using(:dwh_t).where(sistema: 'R', error: true)
    else
      @proveedores = Proveedor.using(:dwh_t).where(sistema: 'RH', error: true)
    end
  end

  def edit
    @proveedor = Proveedor.using(:dwh_t).find(params[:id])
  end

  def destroy
    @proveedor = Proveedor.using(:dwh_t).find(params[:id])
    if @proveedor.destroy
      flash[:notice] = 'Eliminado'
    else
      flash[:alert] = 'Error eliminando'
    end
    redirect_to proveedores_path
  end

  def update
    @proveedor = Proveedor.using(:dwh_t).find(params[:id])
    if validate_attributes && @proveedor.update(proveedor_params)
      @proveedor.update_attributes(error: false)
      flash[:notice] = 'Actualizado'
      redirect_to proveedores_path
    else
      flash.now[:alert] = 'Error actualizando'
      render 'edit'
    end
  end

  def proveedor_params
    params.require(:proveedor).permit(:id_sistema, :nombre, :sistema, :id_empresa)
  end

  def validate_attributes
    valid_name?(params[:proveedor][:nombre])
  end
end
