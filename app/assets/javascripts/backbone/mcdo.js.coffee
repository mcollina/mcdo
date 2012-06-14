#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.MCDO = MCDO =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Templates: {}

$(window).ready ->
  MCDO.login = new MCDO.Models.LoginStatus()
  new MCDO.Views.LoginSignup(model: MCDO.login, el: $("#signup"))
  new MCDO.Views.Logout(model: MCDO.login, el: $(".logout"))

  MCDO.login.verify()
