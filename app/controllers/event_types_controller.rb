class EventTypesController < ApplicationController
  def index 
  end

  def party
    @party = CaterInformation.where(type_of_event: 0)
  end

  def wedding
    @wedding = CaterInformation.where(type_of_event: 1)
  end

  def conference
    @conference = CaterInformation.where(type_of_event: 2)
  end

  def formal
    @formal= CaterInformation.where(type_of_event: 3)
  end

  def cocktail
    @cocktail= CaterInformation.where(type_of_event: 4)
  end

  def concert
    @concert = CaterInformation.where(type_of_event: 5)
  end

end