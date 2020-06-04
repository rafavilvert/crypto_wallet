class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - JacksonPires [COOKIE]"
    session[:curso] = "Curso de Ruby on Rails - JacksonPires [session]"
    @meu_nome = params[:nome]
  end
end
