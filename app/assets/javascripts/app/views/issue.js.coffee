class App.Views.Issue extends Backbone.View

    template: HandlebarsTemplates['app/templates/issue']

    initialize: ->
        @childViews = []

    render: ->
        @$el.html(@template(@model.toJSON()))
        @