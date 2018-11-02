class HomeController < ApplicationController
    def index
        @caterer_information = CatererInformation.all
        @caterer_information = @caterer_information.sample(3)
    end
end