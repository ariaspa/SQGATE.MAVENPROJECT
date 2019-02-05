function loadMain(config) {
	console.log("RuntimeData main", runtimeData);
	var prom = loadHtml("html/main.html");
	$.when(prom).then(function(html) {
		console.log("remove loginScreen");
		$("body").removeClass("loginScreen");
		console.log("fatto");
		$("body").removeClass("image-background");
		var stuff = $("#eme-stuff-cnt");
		$("body").empty();
		$("body").append(stuff);
		$("body").append(html);
		$("#eme-user-name").html(runtimeData.loginData.name + " -  loggato in " + runtimeData.loginData.repos.join(" e "));
		var getFavoritesUrl = makeURL(config, "favorites");
		var favoritesList = [];
		var prom = makeAjaxCall(config, getFavoritesUrl, 'get', {}, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			setupMainHandler(config);
			console.log("Get favorites", data);
			runtimeData.favoritesList = data;
			if (runtimeData.favoritesList.length > 0 && (runtimeData.previousView == "favorites" || runtimeData.previousView == "start")) {
				runtimeData.previousView = runtimeData.currentView;
				runtimeData.currentView = "favorites";
				runtimeData.currentQuery = "";
				console.log("Ho almeno un preferito, switcho");
				$("#eme-favorites-li").addClass("active");
				$("#eme-search-li").removeClass("active");
				console.log("chiamo show");
				$('#eme-tabs-contaniner a[href="#eme-favorites-panel"]').tab('show');
				$("#eme-favorites-panel").addClass("active");
				$("#eme-search-panel").removeClass("active");
				console.log("fatto");
				console.log("trigger");
				$('#eme-tabs-contaniner a[href="#eme-favorites-panel"]').trigger("shown.bs.tab");
				console.log("fatto trigger");
			}
			else {
				runtimeData.previousView = runtimeData.currentView;
				runtimeData.currentView = "search";
				$("#eme-search-li").addClass("active");
				$("#eme-favorites-li").removeClass("active");
				$("#eme-favorites-panel").removeClass("active");
				$("#eme-search-panel").addClass("active");
				$('#eme-tabs-contaniner a[href="#eme-search-panel"]').tab('show');
				if (runtimeData.currentQuery) {
					$("#eme-search-query").val(runtimeData.currentQuery);
					search(config);
				}
			}
		});
	});
}

function setupMainHandler(config) {
	$("body").on("click", "#eme-logout", function(event) {
		event.preventDefault();
		var logoutUrl = makeURL(config, "logout");
		var prom = makeAjaxCall(config, logoutUrl, 'post', {}, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			loadLogin(config);
		});
	});

	$("#eme-preferiti-container tbody").on("click", ".eme-dettaglio-preferito", function(event) {
		console.log("Detail");
		var $tr = $(this).parent();
		console.log($tr.data("uri"));
		var uri = $tr.data("uri");
		var repo = $tr.data("repo");
		loadDetails(config, repo, uri);
	});

	$("#eme-risultati-container tbody").on("click", ".eme-dettaglio-preferito", function(event) {
		console.log("Detail");
		var $tr = $(this).parent();
		console.log($tr.data("uri"));
		var uri = $tr.data("uri");
		var repo = $tr.data("repo");
		loadDetails(config, repo, uri);
	});

	$("#eme-risultati-container tbody").on("click", ".eme-preferito-ricerca", function(event) {
		var $this = $(this);
		var uri = $this.data("uri");
		var repo = $this.data("repo");
		var deleteFavoriteUrl = makeURL(config, "favorites", repo, uri);
		var prom = makeAjaxCall(config, deleteFavoriteUrl, 'delete', {}, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			console.log(data);
			var index = -1;
			for (var i = 0; i < runtimeData.favoritesList.length; i++) {
				var p = runtimeData.favoritesList[i];
				if (p.repo == repo && p.uri == uri) {
					index = i;
					console.log("trovato a indice ", index);
				}
			}
			if (index != -1) {
				runtimeData.favoritesList.splice(index, 1);
			}
			$this.removeClass("eme-preferito-ricerca");
			$this.addClass("eme-unstarred");
			$this.parent().addClass("starUnselected");
			$this.parent().removeClass("starSelected");
		});
	});


	$("#eme-preferiti-container tbody").on("click", ".eme-cancella-preferito", function() {
		console.log("Delete");
		var $tr = $(this).parent();
		console.log($tr.data("uri"));
		var uri = $tr.data("uri");
		var repo = $tr.data("repo");
		var deleteFavoriteUrl = makeURL(config, "favorites", repo, uri);
		var prom = makeAjaxCall(config, deleteFavoriteUrl, 'delete', {}, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			console.log(data);
			var index = -1;
			for (var i = 0; i < runtimeData.favoritesList.length; i++) {
				var p = runtimeData.favoritesList[i];
				if (p.repo == repo && p.uri == uri) {
					index = i;
					console.log("trovato a indice ", index);
				}
			}
			if (index != -1) {
				runtimeData.favoritesList.splice(index, 1);
			}
			$tr.fadeOut(400, function() {
				$(this).remove();
			})
		});
	});

	// gestione attivazione tabs
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		console.log("TAB", e);
		if ($(e.target).prop("id") == "eme-favorites-tab") {
			runtimeData.previousView = runtimeData.currentView;
			runtimeData.currentView = "favorites";
			console.log("Attivata tab preferiti");
			var $tbody = $("#eme-preferiti-container tbody");
			$tbody.empty();
			for(var i = 0; i < runtimeData.favoritesList.length; i++) {
				var str = "<tr data-repo='" + runtimeData.favoritesList[i].repo + "' data-uri='" + runtimeData.favoritesList[i].uri + "'>";
				str += "<td class='eme-dettaglio-preferito'>" + runtimeData.favoritesList[i].projectname + "</td>";
				str += "<td class='eme-dettaglio-preferito'>" + runtimeData.favoritesList[i].codice + "</td>";
				str += "<td class='eme-dettaglio-preferito'>" + runtimeData.favoritesList[i].title + "</td>";
				str += "<td class='starSelected eme-cancella-preferito'><i class='fa fa-star' aria-hidden='true'></i></td></tr>";
				$tbody.append(str);
			}
			console.log("Sort?");
			$.bootstrapSortable(true);
			console.log("Fine sort");
		}
		else {
			console.log("Attivata tab ricerca");
			runtimeData.previousView = runtimeData.currentView;
			runtimeData.currentView = "search";
		}
	});

	//invio nel campo di ricerca
	$("#eme-search-query").on("keypress", function(e) {
		if (e.keyCode == 13) {
			e.preventDefault();
		}
	})
	$("#eme-search-query").on("keyup", function(e) {
		console.log("tasto");
		e.preventDefault();
		if (e.keyCode == 13) {
			console.log("Enter");
			search(config);
		}
	})
	$("#eme-search-button").on("click", function() {
		console.log("Click search");
		search(config);
	})

	//click su stella
	$("#eme-risultati-container tbody").on("click", ".eme-unstarred", function() {
		console.log("star");
		$this = $(this);
		var favoriteData = {
			projectid: $this.data("projectid"),
			repo:  $this.data("repo"),
			title:  $this.data("title"),
			uri:  $this.data("uri"),
			codice: $this.data("codice"),
			wid: $this.data("wid"),
			projectname: $this.data('projectname')
		}
		$(this).removeClass("eme-unstarred");
		$(this).addClass("eme-starred");
		$(this).addClass("eme-preferito-ricerca");

		$this.parent().removeClass("starUnselected");
		$this.parent().addClass("starSelected");
		console.log(favoriteData);
		var favoriteUrl = makeURL(config, "favorites");
		
		console.log("save")
		var prom = makeAjaxCall(config, favoriteUrl, 'post', favoriteData, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			console.log(data);
			var getFavoritesUrl = makeURL(config, "favorites");
			var prom = makeAjaxCall(config, getFavoritesUrl, 'get', {}, runtimeData.loginData.token);
			$.when(prom).then(function(data) {
				console.log("Get favorites", data);
				runtimeData.favoritesList = data;

			});	
		})
	});
}

function search(config) {
	var $tbody = $("#eme-risultati-container tbody");
	$tbody.empty();
	var searchQuery = $("#eme-search-query").val();
	if (searchQuery == runtimeData.currentQuery && runtimeData.searchData) {
		console.log("show cached results");
		drawResultRows(runtimeData.searchData, $tbody);
		return;
	}
	if (searchQuery == "") {
		showError("Attenzione, inserire un termine di ricerca.");
		return;
	}
	console.log("call for search");
	runtimeData.currentQuery = searchQuery;
	var searchUrl = makeURL(config, "search");
	var prom = makeAjaxCall(config, searchUrl, 'get', {searchQuery: searchQuery}, runtimeData.loginData.token);
	$.when(prom).then(function(data) {
		console.log(data);
		if (data.hasOwnProperty("malformed")) { //query malformed
			showError("Attenzione, query non valida.");
		}
		else {
			runtimeData.searchData = data;
			drawResultRows(data, $tbody);
			console.log("Sort?");
			$.bootstrapSortable(true);
			console.log("Fine sort");
		}
	});
}

function drawResultRows(data, $tbody) {
	for(var i = 0; i < data.length; i++) {
		var str = drawResultRow(data[i]);
		$tbody.append(str);
	}
}

function drawResultRow(pd) {
	var codice = "";
	if (pd.hasOwnProperty("custom_fields")) {
		codice = pd.custom_fields.custom.value;
	}
	var img = "";
	var classStar = "starSelected";
	if (pd.favorite) { 
		img += "<i class='fa fa-star eme-preferito-ricerca' aria-hidden='true' data-projectid='" + pd.project.id + "'";
		img += " data-repo='" + pd.repo + "'";
		img += " data-title='" + pd.title + "'";
		img += " data-uri='" + pd['@uri'] + "'";
		img += " data-codice='" + codice + "'";
		img += " data-wid='" + pd.id + "'";
		img += " data-projectname='" + pd.project_name + "'";
		img += "></i>";
	} 
	else {
		classStar = "starUnselected";
		img += "<i class='fa fa-star eme-unstarred' aria-hidden='true' data-projectid='" + pd.project.id + "'";
		img += " data-repo='" + pd.repo + "'";
		img += " data-title='" + pd.title + "'";
		img += " data-uri='" + pd['@uri'] + "'";
		img += " data-codice='" + codice + "'";
		img += " data-wid='" + pd.id + "'";
		img += " data-projectname='" + pd.project_name + "'";
		img += "></i>";
	}
	var str = "<tr data-uri=" + pd['@uri'] + " data-repo=" + pd.repo + ">";
	str += "<td>" + pd.project_name  + "</td>";
	str += "<td>" + codice + "</td>";
	str += "<td class='eme-dettaglio-preferito'>" + pd.title + "</td>";
	str += "<td class='"+classStar+"'>" + img + "</td></tr>";
	return str;
}