function loadLogin(config) {
	console.log("RuntimeData login", runtimeData);
	runtimeData.loginData = {};
	var prom = loadHtml("html/login.html");
	$("body").addClass("loginScreen");
	$.when(prom).then(function(html) {
		$("body").removeClass("white-background");
		var stuff = $("#eme-stuff-cnt");
		$("body").empty();
		$("body").append(stuff);
		$("body").append(html);
		$("#eme-login-username").focus();
		setupLoginHandler(config);
		runtimeData.previousView = runtimeData.currentView;
		runtimeData.currentView = "login";
		console.log("RuntimeData login loaded", runtimeData);
	});
}

function setupLoginHandler(config) {
	$("#eme-faillogin").hide();
	$("#eme-login-button").on("click", function() {
		login(config);
	});
	$("#eme-login-username, #eme-login-password").each(function() {
		$(this).on("keyup", function(e) {
			if (e.keyCode == 13) {
				login(config);
			}
		})
	});
}

function login(config) {
	var url = makeURL(config, "login");
	console.log("URL:",  url);
	var user = $("#eme-login-username").val();
	var pass = $("#eme-login-password").val();
	var prom = makeAjaxCall(config, url, 'post', {username: user, password: pass});
	$.when(prom).then(function(data) {
		console.log("Login success");
		console.log(data);
		runtimeData.loginData = data;
		emptyBody();
		loadMain(config);
	})
}