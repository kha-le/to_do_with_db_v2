require('sinatra')
require('sinatra/reloader')
require('./lib/list')
require('./lib/task')
require('pg')
also_reload('lib/**/*.rb')

DB =PG.connect({:dbname => "to_do_list"})

get("/") do
  erb(:index)
end

get('/lists') do
  @lists = List.all
  erb(:lists)
end

get('/lists/new') do
  erb(:list_form)
end

post('/lists') do
  name = params.fetch('name')
  list = List.new({:name => name, :id => nil})
  list.save()
  erb(:list_success)
end

get('/lists/:id') do
  @list = List.find(params.fetch('id').to_i())
  erb(:list)
end
