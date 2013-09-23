class App.Views.Empty extends Backbone.View


    className: "well well-large"

    render: ->
        @$el.html('<h3>Choose the Project from the left</h3>')
        @