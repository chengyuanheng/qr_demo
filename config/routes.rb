Rails.application.routes.draw do
  root :to=>'upload#show_list'

  post '/file'=>'upload#create_file'

end
