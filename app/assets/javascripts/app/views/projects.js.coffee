class App.Views.Projects extends Backbone.View

    template: HandlebarsTemplates['app/templates/projects']

    events:
        "click a.btn":"newProject"

    newProject: (e)->
        e.preventDefault()
        App.Vent.trigger "project:new"

    initialize: ->
        #renderされる度resetを起動する
        @listenTo @collection, "reset", @render
        #プロジェクトが新しく生成された時イベントを受け取ってコレクションに追加
        @listenTo App.Vent, "project:create", @addToCollection
        #コレクションに追加された時、追加されたものを描画する
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