MCDO.Templates.SignupTemplate = _.template(
  """
  <div class="modal-header">
    <h3>Signup or Login</h3>
  </div>
  <div class="modal-body">
    <form class="well form-horizontal">
    <fieldset>
      <div class="control-group email-control-group">
        <label for="email" class="control-label">Email</label>
        <div class="controls">
          <input name="email" type="email" placeholder="Type your email"></input>
          <span class="hide help-inline"></span>
        </div>
      </div>
      <div class="control-group password-control-group">
        <label for="password" class="control-label">Password</label>
        <div class="controls">
          <input name="password" type="password" placeholder="Password"></input>
          <span class="hide help-inline"></span>
        </div>
      </div>
      <div class="control-group">
        <label for="password-confirmation" class="control-label">Password Confirmation</label>
        <div class="controls">
          <input name="password_confirmation" type="password" placeholder="Password"></input>
          <span class="hide help-inline"></span>
        </div>
      </div>
    </fieldset>
    </form>
  </div>
  <div class="modal-footer">
    <a href="#" class="btn btn-primary signup">Signup</a>
    <a href="#" class="btn btn-success login">Login</a>
  </div>
  """
)
