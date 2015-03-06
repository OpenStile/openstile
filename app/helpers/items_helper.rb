module ItemsHelper
  
  def items_ranked_by_popularity
    ret = Top.all_live + Bottom.all_live +
          Dress.all_live + Outfit.all_live 
  end

end
