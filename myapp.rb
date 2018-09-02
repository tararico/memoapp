
require 'sinatra'
require 'sinatra/reloader'
require 'pathname'
require 'date'

# ルーティング
get '/memos' do
  # アクション
  @title = 'memoapp'
  @content = 'メモアプリ'
  # メモフォルダにあるファイルを一覧表示する
  @ichirans = Pathname.glob("memos/*.txt").map{|i| i.basename(".txt")}
  
  erb :index
end    

post '/memos' do
  #メモフォルダにメモを作成
  File.open("memos/#{params[:memo_title]}.txt", "w") do |f| 
    f.puts(params[:content])
  end
  redirect '/memos'
end
    
get '/memos/new' do
  @title = 'memoapp'
  @content = 'メモアプリ'
  erb :new
end

get '/memos/:memo_title/edit' do
  @title = 'memoapp'
  @content = 'メモアプリ'
  @text = File.read("memos/#{params[:memo_title]}.txt")
  @memo_title = "#{params[:memo_title]}"
  erb :edit
#editする
end

get '/memos/:memo_title' do
  #show メモの詳細確認。変更・削除
  @title = 'memoapp'
  @content = 'メモアプリ'
  @text = File.read("memos/#{params[:memo_title]}.txt")
  @memo_title = "#{params[:memo_title]}"
  erb :show
end

patch '/memos/:memo_title' do
    #update更新保存
    File.open("memos/#{params[:memo_title]}.txt", "w") do |f| 
      f.puts(params[:content])
    end
    redirect '/memos'
end

delete '/memos/:memo_title' do
  #destroy
  File.delete("memos/#{params[:memo_title]}.txt")
  redirect '/memos'
end