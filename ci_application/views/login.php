<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title><?php echo APP_NAME; ?></title>
<meta name="description" content="<?php echo APP_DESCRIPTIONS; ?>"/>
<meta name="keywords" content="<?php echo APP_KEYWORDS; ?>"/>
<meta name="generator" content="<?php echo APP_GENERATOR; ?>"/>

<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">

<link rel="stylesheet" href="<?php echo ASSETS_CSS; ?>bootstrap.css"/>
<link rel="stylesheet" href="<?php echo ASSETS_CSS; ?>jquery.fancybox.css"/>
<link rel="stylesheet" href="<?php echo ASSETS_CSS; ?>style.css"/>
</head>
<body class='login_body'>
	<div class="wrap">
            <h2 style="text-align: center;"><?php echo ucwords(APP_NAME) ; ?></h2>
		<h4 style="text-align: center;">login page</h4>
                <?php echo validation_errors(); ?>
                <?php echo form_open('authentication',array('autocomplete'=>'off'));?>
                
		<div class="login">
			<div class="email">
				<label for="user">Email/User/Nip</label><div class="email-input"><div class="input-prepend"><span class="add-on"><i class="icon-envelope"></i></span><input type="text" id="auth-email-user" name="auth-email-user"/></div></div>
			</div>
			<div class="pw">
				<label for="pw">Password</label><div class="pw-input"><div class="input-prepend"><span class="add-on"><i class="icon-lock"></i></span><input type="password" id="auth-password" name="auth-password"/></div></div>
			</div>
			<div class="remember">
				<label class="checkbox">
					<input type="checkbox" value="1" name="remember"> Remember me on this computer
				</label>
			</div>
		</div>
		<div class="submit">
			<button class="btn btn-red5">Login</button>
		</div>
		</form>
	</div>
<script src="<?php echo ASSETS_JS; ?>jquery.js"></script>
</body>
</html>