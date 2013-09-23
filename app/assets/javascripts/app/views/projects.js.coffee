class App.Views.Projects extends Backbone.View

    template: HandlebarsTemplates['app/templates/projects']

    initialize: ->
        #renderされる度resetを起動する
        @listenTo @collection, "reset", @render
        #collectionをサーバーから取得する
        @collection.fetch({reset:true})

    render: ->
        @$el.html(@template())
        @collection.forEach @renderProject,@
        @

    renderProject: (model) ->
        v = new App.Views.Project({model:model})
        @$('ul').append(v.render().el)