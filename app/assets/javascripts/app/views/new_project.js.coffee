class App.Views.NewProject extends Backbone.View

    template: HandlebarsTemplates['app/templates/new_project']

    events:
        "click button":"saveProject"

    initialize: ->
        @listenTo @model, 'sync', @checkForOwnership
        @listenTo @model, 'invalid', @renderErrors
        @listenTo @model, 'error', @parseErrorResponse

        @model.fetch() unless @model.isNew()

    render: ->
        @$el.html(@template(@model.toJSON()))
        @

    checkForOwnership: ->
        if @model.get('user_id') is App.currentUser.id
            @render()
        else
            App.Vent.trigger "access_denied"

    saveProject: (e) ->
        e.preventDefault()
        @model.set name:@$('#name').val()
        @model.set description:@$('#description').val()
        #server errror発生時にerrorイベントを発火する
        @model.save {},
            success:(model) -> App.Vent.trigger "project:create", model
_.extend App.Views.NewProject.prototype, App.Mixins.Validatable
