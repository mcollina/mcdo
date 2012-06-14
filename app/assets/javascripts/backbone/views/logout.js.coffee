
class MCDO.Views.Logout extends Backbone.View

  initialize: ->
    @model.bind('change:loggedIn', this.render, this)

  events:
    "click #logout" : "logout"

  render: ->
    $(@el).empty()
    if this.model.get('loggedIn')
      $(@el).removeClass("hide")
      $(@el).html MCDO.Templates.Logout
    else
      $(@el).addClass("hide")
      $(@el).html ""
    @

  logout: ->
    console.log "AAA"
    @model.logout()
