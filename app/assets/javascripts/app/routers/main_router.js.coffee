class App.Routers.MainRouter extends Backbone.Router

    routes:
        "":"index"
        "projects":"project"
        "projects/new":"newProject"

    initialize: ->
        @headerView = new App.Views.Header()
        @contentView = new App.Views.Content()


    index: ->
        @layoutViews()
        @contentView.swapMain(new App.Views.Ads())
        @contentView.swapSide(new App.Views.News())


    project: ->
        @layoutViews()
        @contentView.swapMain(new App.Views.Empty())
        @contentView.swapSide(new App.Views.Projects({collection: new App.Collections.Projects}))


    newProject: ->
        @layoutViews()
        @contentView.swapMain(new App.Views.NewProject({model: new App.Models.Project}))
        @contentView.swapSide(new App.Views.Projects({collection: new App.Collections.Projects}))


    layoutViews: ->
        $('#header').html(@headerView.render().el)
        $('#content').html(@contentView.render().el)

