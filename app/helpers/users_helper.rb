module UsersHelper
  def format_basic_info(time)
    format("%.2f", ((time.hour*60)+time.min) / 60.0)
  end
  
  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

  def working_employee_list
    @attendances = Attendance.all.includes(:user)
  end
  
  # CSVインポート
  def import
    if params[:users_file] && File.extname("#{params[:users_file].original_filename}") == ".csv"
      # 登録処理前のレコード数
      current_user_count = User.count
      users = []
      CSV.foreach(params[:users_file].path, headers: true, encoding: "UTF-8") do |row|
        users << User.create({
          name:                            row['name'],
          email:                           row['email'],
          department:                      row['department'],
          employee_number:                 row['employee_number'],
          user_card_id:                    row['user_card_id'],
          basic_time:                      row['basic_time'],
          user_designated_work_start_time: row['user_designated_work_start_time'],
          user_designated_work_end_time:   row['user_designated_work_end_time'],
          superior:                        row['superior'],
          admin:                           row['admin'],
          password:                        row['password'] })
      end
      flash[:success] = "#{User.count - current_user_count}人のアカウントを新規作成しました。"
    else
      flash[:danger] = "CSVファイルを選択してください。"
    end
    redirect_to users_path
  end

  def basic_info_edit
  end
end
