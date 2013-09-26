class IssuesController < ApplicationController
  respond_to :json

  def create
    @issue = Issue.new(issue_params)
    #errorの場合はerrorオブジェクトを返す
    return respond_with(@issue) unless @issue.save

  end

  private

  def issue_params
    params.require(:issue).permit(:name,:description,:project_id)
  end
end
