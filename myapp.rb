require 'sinatra'
require 'sinatra/reloader'
require 'pathname'
require 'yaml'

get '/memos' do
  @memos = Pathname.glob("memos/*.txt").map{|i| i.basename(".txt")}
  erb :index
end

post '/memos' do
  num = Pathname.glob("memos/*.txt").map{ |i| i.basename(".txt").to_i.last.to_i}
  file_name = num + 1
  File.open("memos/#{file_name}.txt", "w") do |f|
    f.puts(params[:content])
  end
  redirect '/memos'
end
    
get '/memos/new' do
  erb :new
end

get '/memos/:memo_title/edit' do
  @text = File.read("memos/#{params[:memo_title]}.txt")
  @memo_title = "#{params[:memo_title]}"
  erb :edit
end

get '/memos/:memo_title' do
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