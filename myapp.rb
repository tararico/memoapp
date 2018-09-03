
require 'sinatra'
require 'sinatra/reloader'
require 'pathname'
require 'date'

get '/memos' do
  @title = 'memoapp'
  @content = 'メモアプリ'
  @ichirans = Pathname.glob("memos/*.txt").map{|i| i.basename(".txt")}
  
  erb :index
end    

post '/memos' do
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
end

get '/memos/:memo_title' do
  @title = 'memoapp'
  @content = 'メモアプリ'
  @text = File.read("memos/#{params[:memo_title]}.txt")
  @memo_title = "#{params[:memo_title]}"
  erb :show
end

patch '/memos/:memo_title' do
    File.open("memos/#{params[:memo_title]}.txt", "w") do |f| 
      f.puts(params[:content])
    end
    redirect '/memos'
end

delete '/memos/:memo_title' do
  File.delete("memos/#{params[:memo_title]}.txt")
  redirect '/memos'
end