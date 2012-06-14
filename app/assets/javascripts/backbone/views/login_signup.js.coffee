
class MCDO.Views.LoginSignup extends Backbone.View

  initialize: ->
    @model.bind('change:loggedIn', this.render, this)

  events: 
    "click a.signup" : "signup"
    "click a.login"  : "login"

  render: ->
    $(@el).empty()
    if !(this.model.get('loggedIn'))
      $(@el).html MCDO.Templates.SignupTemplate
      $(@el).modal
        show: true
        backdrop: "static"
        keyboard: false
    else
      $(@el).modal("hide")
    @

  signup: ->
    user = new MCDO.Models.User

    $.each ["email", "password", "password_confirmation"], (index, attr) =>
      value = $(@el).find("input[name='#{attr}']").val()
      user.set(attr, value)

    user.save {},
      success: =>
        @model.set("loggedIn", true)
      error: (user, response) =>
        json = JSON.parse(response.responseText)
        _(["email", "password", "password_confirmation"]).forEach (attr) =>
          errors = json.errors[attr]
          controlGroup = $(@el).find(".#{attr}-control-group")
          if errors? and errors.length > 0
            controlGroup.addClass("error")
            controlGroup.find(".help-inline").text(errors[0]).removeClass("hide")
          else
            controlGroup.removeClass("error")
            controlGroup.find(".help-inline").empty().addClass("hide")

  login: ->
    alert "login"
