class UsersController < ApplicationController
  include UsersHelper
  
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :edit_one_month]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :edit_one_month]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info, :edit_one_month]
  before_action :admin_or_correct_user, only: :show
  before_action :set_one_month, only: :show

  def index
    @users = User.paginate(page: params[:page])
    if params[:name].present?
      @users = @users.get_by_name params[:name]
    end
  end

  def show
    @worked_sum = @attendances.where.not(started_at: nil, finished_at: nil).count
    
    respond_to do |format|
      format.all
      format.csv do |csv|
        send_posts_csv(@attendances)
      end
    end
  end
  
  def send_posts_csv(attendances)
    csv_data = CSV.generate do |csv|
      header = %w(日付 出社時間 退社時間 備考)
      csv << header

      attendances.each do |day|
        values = [l(day.worked_on, format: :short), day.started_at, day.finished_at, day.note]
        csv << values
      end
    end
    send_data(csv_data, filename: "勤怠情報.csv")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

<<<<<<< HEAD
=======
  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def import
    if params[:file].blank?
      flash[:danger] = "読み込むCSVファイルを選択してください"
      redirect_to users_url
    elsif File.extname(params[:file].original_filename) != ".csv"
      flash[:danger] = "csvファイルのみ読み込み可能です"
      redirect_to users_url
    end
  end

>>>>>>> 2bd5adf2fe1132420affc68ac87363a2b8f9e962
  private
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end

    def basic_info_params
      params.require(:user).permit(:name, :email, :department, :employee_number, :user_card_id, :basic_time, :work_time, :user_designated_work_start_time, :user_designated_work_end_time)
    end
    
    # 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:id]) 
      unless current_user.admin? || current_user?(@user)
        flash[:danger] = "編集・操作権限がありません"
        redirect_to root_url
      end
    end
end