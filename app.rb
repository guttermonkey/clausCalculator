require 'sinatra'
require 'erb'

class ClausConverter < Sinatra::Base
  configure do
    set :onefirsttbl, [21.1, 16.5, 13.2, 11.0, 9.6, 8.8]
    set :onesecondtbl, [14.2, 12.0, 10.4, 9.4, 9.4, 8.3]
    set :twofirsttbl, [[48.4, 46.0, 43.4, 39.7, 35.4, 30.8], [46.0, 43.7, 39.9, 35.3, 30.2, 25.2], [43.4, 39.9, 35.4, 30.0, 24.6, 20.0], [39.7, 35.3, 30.0, 24.5, 19.5, 15.8], [35.4, 30.2, 24.6, 19.5, 15.6, 12.8], [30.8, 25.2, 20.0, 15.8, 12.8, 10.9]]
    set :twosecondtbl, [[26.2, 25.6, 24.5, 23.1, 21.1, 18.9], [25.6, 24.5, 23.0, 20.0, 18.6, 16.2], [24.5, 23.0, 20.9, 18.4, 15.9, 13.7], [23.1, 20.0, 18.4, 15.8, 13.5, 11.7], [21.1, 18.6, 15.9, 13.5, 11.6, 10.3], [18.9, 16.2, 13.7, 11.7, 10.3, 9.4]]
    set :oneeachtbl, [[45.0, 43.3, 40.7, 36.9, 32.0, 26.4], [43.7, 41.4, 37.7, 32.9, 27.4, 21.9], [41.7, 38.3, 33.8, 28.1, 22.5, 17.7], [38.8, 34.3, 28.9, 23.3, 18.2, 14.3], [34.9, 29.6, 23.9, 18.8, 14.8, 12.0], [30.5, 24.8, 19.6, 15.4, 12.4, 10.5]]
  end
  
  def initialize
    super
  end
  
  get '/' do
    erb :home
  end
  
  post '/calc' do
    onesecdeg = !params[:firstdeg1] && !params[:firstdeg2] && params[:secdeg1] && !params[:secdeg2]
    twosecdeg = !params[:firstdeg1] && !params[:firstdeg2] && params[:secdeg1] && params[:secdeg2]
    
    if params[:firstdeg1] && !params[:firstdeg2] && !params[:secdeg1] && !params[:secdeg2]
      @result = settings.onefirsttbl[params[:firstdeg1age].to_i]
    elsif params[:firstdeg1] && params[:firstdeg2]
      @result = settings.twofirsttbl[params[:firstdeg1age].to_i][params[:firstdeg2age].to_i]
    elsif params[:firstdeg1] && params[:secdeg1]
      @result = settings.oneeachtbl[params[:firstdeg1age].to_i][params[:secdeg1age].to_i]
    elsif params[:secdeg1] && !params[:secdeg2]
      @result = settings.onesecondtbl[params[:secdeg1age].to_i]
    end
        
    erb :calc
  end
  
end