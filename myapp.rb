require 'sinatra'
require 'sinatra/reloader'
require 'pathname'
require 'yaml'

get '/memos' do
  @memos = {}
  Pathname.glob("memos/*.txt").map{|i| i.basename(".txt")}.each do |i|
   @memos[i] =  YAML.load_file("memos/#{i}.txt")["title"]
  end
  erb :index
end

post '/memos' do
  num = Pathname.glob("memos/*.txt").map{|i| i.basename(".txt").to_s.to_i}.max || 0
  file_name = num + 1
  data = {'title'=> params[:memo_title], 'body'=> params[:content]}
  File.open("memos/#{file_name}.txt", "w") do |f|
  YAML.dump data, f
  end
  redirect '/memos'
end
    
get '/memos/new' do
  erb :new
end

get '/memos/:memo_title/edit' do
  data = YAML.load_file("memos/#{params[:memo_title]}.txt")
  @text = data['body'] 
  @memo_title = data['title'] 
  @file_name = params[:memo_title]
  erb :edit
end

get '/memos/:memo_title' do
  @file_name = params[:memo_title]
  data = YAML.load_file("memos/#{params[:memo_title]}.txt")
  @text = data['body']
  @memo_title = data['title']
  erb :show
end

patch '/memos/:memo_title' do
  data = {'title'=> params[:title], 'body'=> params[:content]}
  File.open("memos/#{params[:memo_title]}.txt", "w") do |f|
    YAML.dump data, f
  end
  redirect '/memos'
end

delete '/memos/:memo_title' do
  File.delete("memos/#{params[:memo_title]}.txt")
  redirect '/memos'
end