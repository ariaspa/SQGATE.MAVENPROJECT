function loadConfig() {
	return	$.ajax({
		url: "/config.json",
		method: 'GET',
		success: function(data, status, xhr) {
			console.log("success", data);
		},
		error: function(xhr, status, err) {
			console.log(status);
			console.log(err)
		},
		dataType: 'json'
	});
}

function startApp(config) {
	console.log("startApp", config);
	$("body").on("click", ".eme-backtologin", function() {
		console.log("Backtologin");
    	$("#eme-sessionexpired").modal("hide");
    	$("#eme-error").modal("hide");
    	loadLogin(config);
    });
	loadLogin(config);
}

function loadHtml(filename) {
	console.log("loadHtml - load:", filename);
	return	$.ajax({
		url: filename,
		method: 'GET',
		success: function(data, status, xhr) {
			console.log("loadHtml - success");
		},
		error: function(xhr, status, err) {
			console.log("loadHtml");
			console.log(status);
			console.log(err)
		},
	});
}

function makeURL(config, endpoint, repo, uri) {
	console.log(config.endpoint[endpoint]);
	var url = config.baseurl + config.endpoint[endpoint];
	if (repo) {
		url += "/" + repo;
	}
	if (uri) {
		url += "/" + uri;
	}
	return url;
}

function makeAjaxCall(config,url, method, data, token) {
	var headers = {};
	if (token) {
		headers[config.polappheader] =  token
	}
	//headers['Authorization'] = 'Bearer ' + config.apikey; //se tolgo l'header non fa la OPTIONS,
	var prom = $.ajax({
		url: url,
		method: method,
		data: data,
		headers: headers,
		dataType: 'json',
		timeout: 1200000
	});
	return prom;
}

function emptyBody() {
	$("#eme-main-body").empty();
}

function showError(msg) {
	$("#eme-malformed").find(".modal-body").find("p").html(msg);
	$("#eme-malformed").modal("show");
}


