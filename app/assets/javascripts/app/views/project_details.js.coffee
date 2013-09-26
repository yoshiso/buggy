class App.Views.ProjectDetails extends Backbone.View

    template: HandlebarsTemplates['app/templates/project_details']

    events: ->
        "click button.destroy":"deleteProject"
        "click button.edit":"editProject"

    editProject: -> App.Vent.trigger "project:edit", @model


    deleteProject: ->
        return unless confirm('Are you sure?')
        #wait:trueにしない場合はサーバーを待たずにdestroyイベントを発火する
        @model.destroy({wait:true})


    initialize: ->
        @childViews = []
        @listenTo @model, "change", @renderDetails
        @listenTo @model, "error", @triggerAccessDenied
        @listenTo @model, "destroy", @triggerProjectDestroy
        @listenTo App.Vent, "issue:create", @renderNewIssue
        @model.fetch()

    triggerProjectDestroy: -> App.Vent.trigger "project:destroy"
    triggerAccessDenied: -> App.Vent.trigger "access_denied"

    render: ->
        @$el.html(@template(@model.toJSON()))
        @

    renderDetails: ->
        @$el.html(@template(@model.toJSON()))
        v = new App.Views.Issues({collection: @model.issues})
        @childViews.push(v)
        @$('#issues').html(v.render().el)

        @new_issue_v = new App.Views.NewIssue({model:new App.Models.Issue({project_id:@model.id})})
        @childViews.push(@new_issue_v)
        @$('#new_issue').html(@new_issue_v.render().el)

    renderNewIssue: ->
        if @new_issue_v
            @new_issue_v.remove()
            @new_issue_v.off()
        @new_issue_v = new App.Views.NewIssue({model:new App.Models.Issue({project_id:@model.id})})
        @$('#new_issue').html(@new_issue_v.render().el)