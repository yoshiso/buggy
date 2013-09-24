class App.Views.NewProject extends Backbone.View

    template: HandlebarsTemplates['app/templates/new_project']

    events:
        "click button":"saveProject"


    render: ->
        @$el.html(@template(@model.toJSON()))
        @


    saveProject: (e) ->
        e.preventDefault()
        @model.set name:@$('#name').val()
        @model.set description:@$('#description').val()
        @model.save {},
            success:(model) -> App.Vent.trigger "project:create", model
