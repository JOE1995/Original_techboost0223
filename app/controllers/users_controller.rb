class UsersController < ApplicationController
  def login_form
  end

  def show

    # user_idからshopを取得
    @shop = Shop.find_by(user_id: @current_user.id)
    puts @shop.shopname

    # shop_idからkeywordsを全て取得
    @keywords = Keywoed.where(shop_id: @shop.id)

    @keywords.each do |keyword|
      puts keyword.url
      agent = Mechanize.new
      agent.user_agent_alias = "Mac Safari"
      page = agent.get(keyword.url)
      @elements = page.search('.dbg0pd')
      @ads = page.search('.gghBu')
      puts "【@adsの要素数】" + @ads.length.to_s
      rank =  '圏外'
      @elements.each_with_index do |element,i|
        puts element.inner_text
        check = element.inner_text.include?(@shop.shopname)
        if check
          puts("Match!")
          # puts "【順位】" + (rank - @ads.length).to_s
          rank = (i+1- @ads.length).to_s + "位"
          break
        end
      end

      now = Date.current
      puts now
      @search_result = Search_result.find_by(keyword_id: keyword.id, search_date: now)

      if @search_result.nil?
        @search_result = Search_result.new(keyword_id: keyword.id, search_date: now , rank: rank)
        @search_result.save
      end

    end

    @search_results = Search_result.new

  end

  def login
    @user = User.find_by(email: params[:@user][:email], password: params[:@user][:password])
    if @user
      session[:user_id] = @user.id
      # flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}", success: 'ログインに成功しました')

    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      flash.now[:danger] = "ログインに失敗しました"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

end
