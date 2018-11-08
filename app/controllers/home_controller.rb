class HomeController < ApplicationController
    def index
        #Chooses 3 random entries from CatererInformation in an efficient manner
        @caterer_information = CatererInformation.order('RANDOM()').limit(3)
    end
end