class UserImportFilesController < ApplicationController
  before_action :set_user_import_file, only: [:show, :edit, :update, :destroy]
  before_action :check_policy, only: [:index, :new, :create]
  before_action :prepare_options, only: [:new, :edit]

  # GET /user_import_files
  # GET /user_import_files.json
  def index
    @user_import_files = UserImportFile.order(id: :desc).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_import_files }
    end
  end

  # GET /user_import_files/1
  # GET /user_import_files/1.json
  def show
    if @user_import_file.user_import.path
      unless Rails.application.config_for(:enju_leaf)["uploaded_file"]["storage"] == :s3
        file = @user_import_file.user_import.path
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_import_file }
      format.download {
        if Rails.application.config_for(:enju_leaf)["uploaded_file"]["storage"] == :s3
          redirect_to @user_import_file.user_import.expiring_url(10)
        else
          send_file file, filename: @user_import_file.user_import_file_name, type: 'application/octet-stream'
        end
      }
    end
  end

  # GET /user_import_files/new
  # GET /user_import_files/new.json
  def new
    @user_import_file = UserImportFile.new
    @user_import_file.default_user_group = current_user.profile.user_group
    @user_import_file.default_library = current_user.profile.library

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_import_file }
    end
  end

  # GET /user_import_files/1/edit
  def edit
  end

  # POST /user_import_files
  # POST /user_import_files.json
  def create
    @user_import_file = UserImportFile.new(user_import_file_params)
    @user_import_file.user = current_user

    respond_to do |format|
      if @user_import_file.save
        if @user_import_file.mode == 'import'
          UserImportFileJob.perform_later(@user_import_file)
        end
        format.html { redirect_to @user_import_file, notice: t('import.successfully_created', model: t('activerecord.models.user_import_file')) }
        format.json { render json: @user_import_file, status: :created, location: @user_import_file }
      else
        prepare_options
        format.html { render action: "new" }
        format.json { render json: @user_import_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_import_files/1
  # PUT /user_import_files/1.json
  def update
    respond_to do |format|
      if @user_import_file.update_attributes(user_import_file_params)
        if @user_import_file.mode == 'import'
          UserImportFileJob.perform_later(@user_import_file)
        end
        format.html { redirect_to @user_import_file, notice: t('controller.successfully_updated', model: t('activerecord.models.user_import_file')) }
        format.json { head :no_content }
      else
        prepare_options
        format.html { render action: "edit" }
        format.json { render json: @user_import_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_import_files/1
  # DELETE /user_import_files/1.json
  def destroy
    @user_import_file.destroy

    respond_to do |format|
      format.html { redirect_to(user_import_files_url) }
      format.json { head :no_content }
    end
  end

  private
  def set_user_import_file
    @user_import_file = UserImportFile.find(params[:id])
    authorize @user_import_file
    access_denied unless LibraryGroup.site_config.network_access_allowed?(request.ip)
  end

  def check_policy
    authorize UserImportFile
  end

  def user_import_file_params
    params.require(:user_import_file).permit(
      :user_import, :edit_mode, :user_encoding, :mode,
      :default_user_group_id, :default_library_id
    )
  end

  def prepare_options
    @user_groups = UserGroup.all
    @libraries = Library.all
  end
end
