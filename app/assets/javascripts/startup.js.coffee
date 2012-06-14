
opts =
  lines: 12, # The number of lines to draw
  length: 40, # The length of each line
  width: 10, # The line thickness
  radius: 20, # The radius of the inner circle
  rotate: 0, # The rotation offset
  color: '#555', # #rgb or #rrggbb
  speed: 1, # Rounds per second
  trail: 60, # Afterglow percentage
  shadow: false, # Whether to render a shadow
  hwaccel: false, # Whether to use hardware acceleration
  zIndex: 0, # The z-index (defaults to 2000000000)
  top: '0px', # Top position relative to parent in px
  left: '0px' # Left position relative to parent in px

$(document).ready ->
  $('#startup-spinner').each (index, target) ->
    new Spinner(opts).spin(target)
