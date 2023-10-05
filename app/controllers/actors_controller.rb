class ActorsController < ApplicationController

  def update

   actor_id = params.fetch("a_id")
   
   matching_actors_relation = Actor.where({ :id => actor_id})

   solution = matching_actors_relation.at(0)

   solution.name = params.fetch("the_name")
   solution.dob = params.fetch("the_birth")
   solution.bio = params.fetch("the_bio")
   solution.image = params.fetch("the_image")

   solution.save 
   redirect_to("/actors/#{solution.id}")
  end 

  def destroy
    the_id = params.fetch("actor_id") 
    relating_actor  = Actor.where({ :id => the_id})
    the_actor = relating_actor.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end 

  def create

    a = Actor.new

    a.name = params.fetch("the_name")
    a.dob = params.fetch("the_birth")
    a.bio = params.fetch("the_bio")
    a.image = params.fetch("the_image")

    a.save 
   
    redirect_to("/directors")
    
  end


  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
