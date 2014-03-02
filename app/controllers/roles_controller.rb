class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, :only => :index

  # GET /roles
  def index
    authorize Role
    @roles = Role.all
  end

  # GET /roles/1
  def show
  end

  # GET /roles/1/edit
  def edit
  end

  # PUT /roles/1
  def update
    if params[:move]
      move_position(@role, params[:move])
      return
    end

    if @role.update_attributes(role_params)
      redirect_to @role, notice: t('controller.successfully_updated', :model => t('activerecord.models.role'))
    else
      render action: 'edit'
    end
  end

  private
  def set_role
    @role = Role.find(params[:id])
    authorize @role
  end

  def role_params
    params.require(:role).permit(
      :name, :display_name, :note
    )
  end
end
