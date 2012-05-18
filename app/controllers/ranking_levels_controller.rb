class RankingLevelsController < ApplicationController

  before_filter :login_required
  filter_access_to :all

  def index
    @ranking_levels = RankingLevel.all(:order=> "priority ASC")
    @ranking_level = RankingLevel.new
  end

  def create_ranking_level
    priority = 1
    ranks = RankingLevel.all
    unless ranks.empty?
      last_priority = ranks.map{|r| r.priority}.sort.last
      priority = last_priority + 1
    end
    @ranking_level = RankingLevel.new(params[:ranking_level])
    @ranking_level.priority = priority
    if @ranking_level.save
      @ranking_level = RankingLevel.new
      @ranking_levels = RankingLevel.all(:order=> "priority ASC")
      render(:update) do|page|
        page.replace_html "category-list", :partial=>"ranking_levels"
        page.replace_html 'flash', :text=>'<p class="flash-msg"> Ranking Level created successfully. </p>'
        page.replace_html 'errors', :partial=>"rank_errors"
        page.replace_html 'rank_form', :partial=>"rank_form"
      end
    else
      render(:update) do|page|
        page.replace_html 'errors', :partial=>'rank_errors'
        page.replace_html 'flash', :text=>""
      end
    end
  end

  def edit_ranking_level
    @ranking_level = RankingLevel.find(params[:id])
    render(:update) do|page|
      page.replace_html "rank_form", :partial=>"rank_edit_form"
      page.replace_html 'errors', :partial=>'rank_errors'
      page.replace_html 'flash', :text=>""
    end
  end

  def update_ranking_level
    @ranking_level = RankingLevel.find(params[:id])
    if @ranking_level.update_attributes(params[:ranking_level])
      @ranking_level = RankingLevel.new
      @ranking_levels = RankingLevel.all(:order=> "priority ASC")
      render(:update) do|page|
        page.replace_html "category-list", :partial=>"ranking_levels"
        page.replace_html 'flash', :text=>'<p class="flash-msg"> Ranking Level updated successfully. </p>'
        page.replace_html 'errors', :partial=>"rank_errors"
        page.replace_html 'rank_form', :partial=>"rank_form"
      end
    else
      render(:update) do|page|
        page.replace_html 'errors', :partial=>'rank_errors'
        page.replace_html 'flash', :text=>""
      end
    end
  end
  
  def delete_ranking_level
    @ranking_level = RankingLevel.find(params[:id])
    if @ranking_level.destroy
      @ranking_level = RankingLevel.new
      @ranking_levels = RankingLevel.all(:order=> "priority ASC")
      render(:update) do|page|
        page.replace_html "category-list", :partial=>"ranking_levels"
        page.replace_html 'flash', :text=>'<p class="flash-msg"> Ranking Level deleted successfully. </p>'
        page.replace_html 'errors', :partial=>"rank_errors"
        page.replace_html 'rank_form', :partial=>"rank_form"
      end
    else
      render(:update) do|page|
        page.replace_html 'errors', :partial=>'rank_errors'
        page.replace_html 'flash', :text=>""
      end
    end
  end

  def change_priority
    @ranking_level = RankingLevel.find(params[:id])
    priority = @ranking_level.priority
    @ranking_levels = RankingLevel.all(:order=> "priority ASC").map{|b| b.priority.to_i}
    position = @ranking_levels.index(priority)
    if params[:order]=="up"
      prev_rank = RankingLevel.find_by_priority(@ranking_levels[position - 1])
    else
      prev_rank = RankingLevel.find_by_priority(@ranking_levels[position + 1])
    end
    @ranking_level.update_attributes(:priority=>prev_rank.priority)
    prev_rank.update_attributes(:priority=>priority.to_i)
    @ranking_level = RankingLevel.new
    @ranking_levels = RankingLevel.all(:order=> "priority ASC")
    render(:update) do|page|
      page.replace_html "category-list", :partial=>"ranking_levels"
    end
  end

end