class MCDO.Models.LoginStatus extends Backbone.Model
  defaults: 
    loggedIn: null

  verify: ->
    $.ajax 
      url: "/session"
      dataType: "json"
      success: (data) =>
        @set("loggedIn", true)
      error: =>
        @set("loggedIn", false)

  logout: ->
    $.ajax 
      url: "/session"
      method: "DELETE"
      dataType: "json"
      complete: (data) =>
        @set("loggedIn", false)

