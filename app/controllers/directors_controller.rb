class DirectorsController < ApplicationController
  def update 

   director_id = params.fetch("direct_id")
   
   matching_director_relation = Director.where({:id => director_id})

   solution = matching_director_relation.at(0)

   solution.name = params.fetch("the_name")
   solution.dob = params.fetch("the_birth")
   solution.bio = params.fetch("the_bio")
   solution.image = params.fetch("the_image")

   solution.save 
   redirect_to("/directors/#{solution.id}")
  end 

   
  def destroy
    dir_id = params.fetch("direct_id")
    director_container= Director.where({:id => dir_id})
    the_director = director_container.at(0)

    the_director.destroy 
    
    redirect_to("/directors")

  end 

  def create 
    dir = Director.new

    dir.name = params.fetch("the_name")
    dir.dob = params.fetch("the_birth")
    dir.bio = params.fetch("the_bio")
    dir.image = params.fetch("the_image")
    dir.save 

    redirect_to("/directors")
  end 

  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
