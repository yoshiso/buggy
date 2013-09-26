class App.Views.Issues extends Backbone.View

    template: HandlebarsTemplates['app/templates/issues']

    initialize: ->
        @childViews = []
        @listenTo App.Vent, "issue:create", @addToCollection
        @listenTo @collection, "add", @renderIssue
        @listenTo @collection, "add", @updateCount

    updateCount: ->
        @$('span').text(@collection.length)

    addToCollection: (model) ->
        @collection.add(model)
        App.Vent.trigger "issues:change",model,@collection.length

    render: ->
        @$el.html(@template({count:@collection.length}))
        @collection.forEach @renderIssue, @
        @

    renderIssue: (model) ->
        console.log "renderissue"
        v = new App.Views.Issue({model:model})
        @childViews.push(v)
        @$('#issues_list').append(v.render().el)