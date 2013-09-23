class App.Views.Projects extends Backbone.View

    template: HandlebarsTemplates['app/templates/projects']

    events:
        "click a.btn":"newProject"

    newProject: ->
        

    initialize: ->
        #renderされる度resetを起動する
        @listenTo @collection, "reset", @render
        @listenTo App.Vent, "project:create", @addToCollection
        @listenTo @collection, "add", @renderProject
        #collectionをサーバーから取得する
        @collection.fetch({reset:true})

    addToCollection: (model) ->
        @collection.add model

    render: ->
        @$el.html(@template())
        @collection.forEach @renderProject,@
        @

    renderProject: (model) ->
        v = new App.Views.Project({model:model})
        @$('ul').append(v.render().el)