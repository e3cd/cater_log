class EventTypesController < ApplicationController
  def index 
  end

  def party
    @party = CatererInformation.where(type_of_event: 1)
  end

  def wedding
    @wedding = CatererInformation.where(type_of_event: 0)
  end

  def conference
    @conference = CatererInformation.where(type_of_event: 2)
  end

  def formal
    @formal= CatererInformation.where(type_of_event: 3)
  end

  def cocktail
    @cocktail= CatererInformation.where(type_of_event: 4)
  end

  def concert
    @concert = CatererInformation.where(type_of_event: 5)
  end

end