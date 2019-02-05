var pdStatuses = {
	IN_LAVORAZIONE: "IN LAVORAZIONE",
	CHIUSO: "CHIUSO",
	IN_RITARDO: "IN RITARDO",
	CHIUSO_RITARDO: "CHIUSO IN RITARDO",
	INVALID: "STATO NON PREVISTO",
	IN_LAVORAZIONE_NON_PIANIFICATO: "IN LAVORAZIONE NON PIANIFICATO",
	SOSPESO: "SOSPESO",
	COMPLETATO: "COMPLETATO",
	COMPLETATO_RITARDO: "COMPLETATO IN RITARDO"
}

var pdStatusesColor = {
	IN_LAVORAZIONE: "eme-grassetto",
	CHIUSO: "eme-grassetto eme-grigio",
	IN_RITARDO: "eme-grassetto eme-rosso",
	CHIUSO_RITARDO: "eme-grassetto eme-grigio",
	INVALID: "eme-grassetto",
	IN_LAVORAZIONE_NON_PIANIFICATO: "eme-grassetto",
	SOSPESO: "eme-grassetto",
	COMPLETATO: "eme-grassetto",
	COMPLETATO_RITARDO: "eme-grassetto eme-rosso"
}

var filieraStatuses = {
	IN_SVILUPPO: "IN SVILUPPO",
	IN_SVILUPPO_RITARDO: "IN SVILUPPO IN RITARDO",
	IN_INTEGRAZIONE: "IN INTEGRAZIONE",
	IN_INTEGRAZIONE_RITARDO: "IN INTEGRAZIONE IN RITARDO",
	IN_SVILUPPO_FIX: "IN SVILUPPO FIX",
	IN_SVILUPPO_FIX_RITARDO: "IN SVILUPPO FIX IN RITARDO",
	IN_SERVIZI: "IN SERVIZI",
	IN_SERVIZI_RITARDO: "IN SERVIZI IN RITARDO",
	CHIUSO: "CHIUSO",
	CHIUSO_RITARDO: "CHIUSO IN RITARDO",
	INVALID: "STATO NON PREVISTO"
}

var filieraStatusesColor = {
	IN_SVILUPPO: "eme-grassetto",
	IN_SVILUPPO_RITARDO: "eme-grassetto eme-rosso",
	IN_INTEGRAZIONE: "eme-grassetto",
	IN_INTEGRAZIONE_RITARDO: "eme-grassetto eme-rosso",
	IN_SVILUPPO_FIX: "eme-grassetto",
	IN_SVILUPPO_FIX_RITARDO: "eme-grassetto eme-rosso",
	IN_SERVIZI: "eme-grassetto",
	IN_SERVIZI_RITARDO: "eme-grassetto eme-rosso",
	CHIUSO: "eme-grassetto eme-grigio",
	CHIUSO_RITARDO: "eme-grassetto eme-grigio",
	INVALID: "eme-grassetto"
}

var macroFasi = {
	SVILUPPO: "svi",
	IT: "it",
	SERVIZI: "ser",
	CHIUSO: "chiuso",
	INVALID: "N/A"
}

var helpText = {};
helpText[filieraStatuses.IN_SVILUPPO] = "Il rilascio è in carico a: SVILUPPO<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%";
helpText[filieraStatuses.IN_SVILUPPO_RITARDO] = "ll rilascio è in carico a: SVILUPPO<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto% e la sua data di consegna è scaduta da: %ritardo% giorni";
helpText[filieraStatuses.IN_INTEGRAZIONE] = "ll rilascio è in carico a: INTEGRAZIONE TECNICA<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%<br />Il workitem RELEASE IT è in stato: %statoReleaseIT%";
helpText[filieraStatuses.IN_INTEGRAZIONE_RITARDO] = "ll rilascio è in carico a: INTEGRAZIONE TECNICA<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%<br />Il workitem RELEASE IT è in stato: %statoReleaseIT% e la sua data di consegna è scaduta da: %ritardo% giorni";
helpText[filieraStatuses.IN_SVILUPPO_FIX] = "ll rilascio è tornato in carico a: SVILUPPO poichè IT ha riscontrato delle FIX da correggere<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%<br />Il workitem RELEASE IT è in stato: %statoReleaseIT%";
helpText[filieraStatuses.IN_SVILUPPO_FIX_RITARDO] = "ll rilascio è tornato in carico a: SVILUPPO poichè IT ha riscontrato delle FIX da correggere<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%<br />Il workitem RELEASE IT è in stato: %statoReleaseIT% e la sua data di consegna è scaduta da: %ritardo% giorni";
helpText[filieraStatuses.IN_SERVIZI] = "ll rilascio è in carico a: SERVIZI<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%<br />Il workitem RELEASE DI SERVIZI è in stato: %statoReleaseServizi%";
helpText[filieraStatuses.IN_SERVIZI_RITARDO] = "ll rilascio è in carico a: SERVIZI<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%<br />Il workitem RELEASE DI SERVIZI è in stato: %statoReleaseServizi% e la sua data di consegna è scaduta da: %ritardo% giorni";
helpText[filieraStatuses.CHIUSO] = "ll rilascio è in carico a: SVILUPPO<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto%";
helpText[filieraStatuses.CHIUSO_RITARDO] = "ll rilascio è in carico a: SVILUPPO<br />Il workitem RELEASE DI PROGETTO è in stato: %statoReleaseProgetto% e la sua data di consegna è scaduta da: %ritardo% giorni";
helpText[filieraStatuses.INVALID] = "Stato non previsto, i dati non sono consistenti."


function loadDetails(config, repo, uri) {
	console.log("RuntimeData details", runtimeData);
	console.log("Details", repo, uri);
	var prom = loadHtml("html/details.html");
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
		setupDetailsHandler(config);
		runtimeData.previousView = runtimeData.currentView;
		runtimeData.currentView = "detail";
		var detailsUrl = makeURL(config, "progettodemand", repo, uri);
		var prom = makeAjaxCall(config, detailsUrl, 'get', {}, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			console.log("Details done");
			console.log(data);
			fillDetails(data, config);
			prepareReadMore();
			prepareDescriptionReadMore();
			prepareFilieraReadMore();
		})
	});
	
}

function prepareFilieraReadMore() {
	$(".filieraReadMoreSpan").on("click", function() {
		var $caption = $(this).prev();
		var collapsed = $caption.attr('data-expanded')!='true';	
		if (collapsed) {
			$caption.attr('data-expanded','true');
			$(this).text("Leggi meno...");
			$caption.attr('data-short',$caption.text());
			$caption.text($caption.attr('data-full'));
		}
		else {
			$caption.removeAttr('data-expanded');
			$(this).text("Leggi tutto...");
			$caption.text($caption.attr('data-short'));
		}
	})
}

function prepareDescriptionReadMore() {
	$(".descriptionReadMoreSpan").on("click", function() {
		var $caption = $(this).prev();
		var collapsed = $caption.attr('data-expanded')!='true';	
		if (collapsed) {
			$caption.attr('data-expanded','true');
			$(this).text("Leggi meno...");
			$caption.attr('data-short',$caption.text());
			$caption.text($caption.attr('data-full'));
		}
		else {
			$caption.removeAttr('data-expanded');
			$(this).text("Leggi tutto...");
			$caption.text($caption.attr('data-short'));
		}
	})
}

function prepareReadMore() {
	$('#readMoreSpan').click(function(){
		var $caption = $('#captionSpan');
		//is the caprion collapsed
		var collapsed = $caption.attr('data-expanded')!='true';	
		
		if (collapsed){
			//is collapsed - I'm expanding it now
			//store the flag that caption is now expanded
			$caption.attr('data-expanded','true');
			//change text to 'Read less'
			$('#readMoreSpan').text("Leggi meno...");
			//store short version
			$caption.attr('data-short',$caption.text());
			//use full version
			$caption.text($caption.attr('data-full'));
		}else{
			//its expanded - I'm collapsing now
			//remove expanded flag from DOM
			$caption.removeAttr('data-expanded');
			//change text
			$('#readMoreSpan').text("Leggi tutto...");
			//use short version of caption
			$caption.text($caption.attr('data-short'));
		}
	});
}

function cutStringSize(string, maxLength) {
	var trimmedString = string.substr(0, maxLength); //trim the string to the maximum length
	//re-trim if we are in the middle of a word
	trimmedString = trimmedString.substr(0, Math.min(trimmedString.length, trimmedString.lastIndexOf(" ")))
	return trimmedString;
}

function setupDetailsHandler(config) {
	$("body").on("click", "#eme-logout", function(event) {
		event.preventDefault();
		var logoutUrl = makeURL(config, "logout");
		var prom = makeAjaxCall(config, logoutUrl, 'post', {}, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			loadLogin(config);
		});
	});
	
	$(".content").on("click", "#eme-back", function() {
		console.log("<-back to ", runtimeData.currentQuery);
		loadMain(config);
	});

	$("#eme-help-button").on("click", function(e) {
		e.preventDefault();
		console.log("click help");
		var prom = loadHtml("html/help.html");
		$.when(prom).then(function(html) {
			$("#eme-help-body").html(html);
			$("#eme-help-modal").modal("show");
		});
		
	});
	$("eme-help-modal").modal("show");

	$("body").popover({
		title: 'Help',
		placement: 'auto right',
		html: true,
		trigger: 'focus',
		selector: ".eme-help-btn",
		content: prepareHelpText
	});

}

function manageStar(pd, config) {
	console.log("Dentro manageStar", pd);
	var isFav = pd.favorite;
	var $star = $("#eme-star-detail");
	var codice = "";
	if (pd.hasOwnProperty("custom_fields")) {
		codice = pd.custom_fields.custom.value;
	}
	console.log("project", pd.project);
	$star.data("repo", pd.repo);
	$star.data("uri", pd['@uri']);
	$star.data("projectid", pd.project.id);
	$star.data("title", pd.title);
	$star.data("codice", codice);
	$star.data("wid", pd.id);
	$star.data("projectname", pd.project_name);

	console.log($star);
	if (isFav) {
		$star.removeClass("starUnselected");
		$star.addClass("starSelected");
		$star.on("click", function() {
			removeFavorite(this, config);
		});
	}
	else {
		$star.removeClass("starSelected");
		$star.addClass("starUnselected");
		$star.on("click", function() {
			addFavorite(this, config);
		});
	}
}

function addFavorite(el, config) {
	$this = $(el);
	var favoriteData = {
		projectid: $this.data("projectid"),
		repo:  $this.data("repo"),
		title:  $this.data("title"),
		uri:  $this.data("uri"),
		codice: $this.data("codice"),
		wid: $this.data("wid"),
		projectname: $this.data('projectname')
	}
	$this.removeClass("starUnselected");
	$this.addClass("starSelected");
	console.log(favoriteData);
	var favoriteUrl = makeURL(config, "favorites");
	var prom = makeAjaxCall(config, favoriteUrl, 'post', favoriteData, runtimeData.loginData.token);
	$.when(prom).then(function(data) {
		console.log(data);
		var getFavoritesUrl = makeURL(config, "favorites");
		var prom = makeAjaxCall(config, getFavoritesUrl, 'get', {}, runtimeData.loginData.token);
		$.when(prom).then(function(data) {
			console.log("Get favorites", data);
			runtimeData.favoritesList = data;
		});	
		$this.off("click");
		$this.on("click", function() {
			removeFavorite(this, config);
		})
	});
}

function removeFavorite(el, config) {
	console.log("Delete");
	var $this = $(el);
	console.log($this.data("uri"));
	var uri = $this.data("uri");
	var repo = $this.data("repo");
	var deleteFavoriteUrl = makeURL(config, "favorites", repo, uri);
	var prom = makeAjaxCall(config, deleteFavoriteUrl, 'delete', {}, runtimeData.loginData.token);
	$.when(prom).then(function(data) {
		$this.removeClass("starSelected");
		$this.addClass("starUnselected");
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
		$this.off("click");
		$this.on("click", function() {
			addFavorite(this, config);
		});
	});
}


function fillDetails(pd, config) {
	console.log("Dati Progetto demand e filiere");
	console.log(pd);
	manageStar(pd, config);
	$cnt = $("#eme-detail-content");

	var descr = "";
	if (pd.description) {
		descr = pd.description.content;
		if (descr == null) {
			descr = "";
		}
		else {
			descr = pd.description.content.replace(/(\r\n|\n|\r)/gm, "");
			descr = $("<div/>").html(descr).text();
			descr = descr.replace(/"/g, "&quot;");
			descr = descr.replace(/'/g, "&apos;");
		}
	}
	console.log("DESCR:", descr);
	var status = getProgettoDemandStatus(pd);
	var dueDate = pd.due_date || null;
	var resolvedOn = pd.resolved_on || null;
	var ritardo = null;
	if (status.status == pdStatuses.IN_RITARDO || status.status == pdStatuses.CHIUSO_RITARDO) {
		console.log("Sono in ritardo, calcolo i giorni");
		if (status.status == pdStatuses.IN_RITARDO) {
			ritardo = getDayDifference(dueDate)
		}
		if (status.status == pdStatuses.CHIUSO_RITARDO) {
			ritardo = getDayDifference(dueDate, resolvedOn);
		}
		console.log("Giorni", ritardo);
	}
	var codiceRilascio = getCustomField(pd, "codice");
	if (codiceRilascio == null) {
		codiceRilascio = "";
	}

	var html =  getProgettoDemandHTML(pd.title, codiceRilascio, formatDate(dueDate), formatDate(resolvedOn), status.html, descr, pd.id, ritardo);

	$("#eme-star-detail").after(html);
	var releases = pd.releases;
	if (releases.length > 0){
			$("#eme-progettodemand-details").after("<h4 id='eme-titolo-filiera'>Rilasci associati</h4>");
	}
	for (var i = 0; i < releases.length; i++) {
		drawFiliera(releases[i]);
	}
}

function drawFiliera(release) {
	console.log("Release", release.id);
	var rit = release.release_it || null;
	console.log("RIT", rit);
	var rser = null;
	if (rit != null) {
		rser = rit.release_ser;
	}
	console.log("RSER", rser);	
	
	var stato = getFilieraStatus(release, rit, rser);
	console.log("Stato filiera", stato);
	var title = "";
	var wid = "";
	var dataDispPrevista = "";
	var dataDispEffettiva = "";
	var statusRdp;
	statusRdp = release.status.id;
	if (stato.macroFase == macroFasi.SVILUPPO) {
		console.log("macrofase svil");
		title = release.title;
		wid = release.id;
		dataDispPrevista = release.due_date;
		dataDispEffettiva = release.resolved_on;
	}
	var statusRit = null;
	if (rit != null) {
		statusRit = rit.status.id;
	}
	var statusRser = null;
	if (rser != null) {
		statusRser = rser.status.id;
	}

	if (stato.macroFase == macroFasi.IT) {
		console.log("macrofase it");
		if (rit != null) {
			title = rit.title;
			wid = rit.id;
			dataDispPrevista = getCustomField(rit, "data_it_end");
			dataDispEffettiva = getCustomField(rit, "_fineIT");
		}
		else {
			title = "-= NON ESISTE LA RELEASE IT COLLEGATA ALLA RELEASE DI PROGETTO " + release.id + " =-"; // non dovrebbe capitare
			wid = "N/A";
			dataDispPrevista = "N/A";
			dataDispEffettiva = "N/A";
		}
	}
	if (stato.macroFase == macroFasi.SERVIZI) {
		console.log("macrofase servizi");
		if (rser != null) {
			title = rser.title;
			wid = rser.id;
			dataDispPrevista = rser.due_date;
			dataDispEffettiva = rser.resolved_on;
		}
		else {
			title = "-= NON ESISTE LA RELEASE SERVIZI COLLEGATA ALLA RELEASE DI PROGETTO " + release.id + " =-"; // non dovrebbe capitare
			wid = "N/A";
			dataDispPrevista = "N/A";
			dataDispEffettiva = "N/A";
		}
	}
	if (stato.macroFase == macroFasi.CHIUSO) {
		title = release.title;
		wid = release.id;
		dataDispPrevista = release.due_date;
		dataDispEffettiva = release.resolved_on;
	}
	if (stato.macroFase == macroFasi.INVALID) {
		title = release.title;
		wid = release.id;
		dataDispPrevista = release.due_date;
		dataDispEffettiva = release.resolved_on;
	}

	var ritardoFiliera = null;
	if (stato.status == filieraStatuses.IN_SVILUPPO_RITARDO || stato.status == filieraStatuses.IN_INTEGRAZIONE_RITARDO ||
		stato.status == filieraStatuses.IN_SVILUPPO_FIX_RITARDO || stato.status == filieraStatuses.CHIUSO_RITARDO || stato.status == filieraStatuses.IN_SERVIZI_RITARDO) {
		console.log("Filiera in ritardo, calcolo i giorni");
		var now = moment();
		

		var dueDateRdp = null;
		var resolvedOnRdp = null;
		
		if (release != null) {
			if (release.hasOwnProperty("due_date")) {
				dueDateRdp = moment(release.due_date);
			}
			if (release.hasOwnProperty('resolved_on')) {
				resolvedOnRdp = moment(release.resolved_on);
			}
		}
		
		var dueDateRit = null;
		var resolvedOnRit = null;
		
		if (rit != null) {	
			if (getCustomField(rit, "data_it_end") != null) {
				dueDateRit = moment(getCustomField(rit, "data_it_end"));
			}
			if (getCustomField(rit, "_fineIT")) {
				resolvedOnRit = moment(getCustomField(rit, "_fineIT"));
			}
		}

		var dueDateRser = null;
		var resolvedOnRser = null;
		
		if (rser != null) {
			if (rser.hasOwnProperty("due_date")) {
				dueDateRser = moment(rser.due_date);
			}
			if (rser.hasOwnProperty('resolved_on')) {
				resolvedOnRser = moment(rser.resolved_on);
			}
		} 
		console.log("dueDateRdp", dueDateRdp);
		console.log("resolvedOnRdp", resolvedOnRdp);
		console.log("dueDateRit", dueDateRit);
		console.log("resolvedOnRit", resolvedOnRit);
		console.log("dueDateRser", dueDateRser);
		console.log("resolvedOnRser", resolvedOnRser);

		if (stato.status == filieraStatuses.IN_INTEGRAZIONE_RITARDO) {
			if (!dueDateRit) {
				ritardoFiliera = "DUEDATE RELEASE IT NON PRESENTE";
			}
			else {
				ritardoFiliera = getDayDifference(dueDateRit, now);
			}
		}
		if (stato.status == filieraStatuses.IN_SERVIZI_RITARDO) {
			if (!dueDateRser) {
				ritardoFiliera = "DUEDATE RELEASE SERVIZI NON PRESENTE";
			}
			else {
				ritardoFiliera = getDayDifference(dueDateRser, resolvedOnRser);
			}
		}
		if (stato.status == filieraStatuses.IN_SVILUPPO_RITARDO) {
			if (!dueDateRdp) {
				ritardoFiliera = "DUEDATE RELEASE DI PROGETTO NON PRESENTE";
			} 
			else if (!resolvedOnRdp) {
				ritardoFiliera = getDayDifference(dueDateRdp, now);
			}
			else {
				ritardoFiliera = getDayDifference(resolvedOnRdp, dueDateRdp);
			}
		}
		if (stato.status == filieraStatuses.IN_SVILUPPO_FIX_RITARDO) {
			if (!dueDateRdp) {
				ritardoFiliera = "DUEDATE RELEASE DI PROGETTO NON PRESENTE";
			} 
			else if (!resolvedOnRdp) {
				ritardoFiliera = getDayDifference(dueDateRdp, now);
			}
			else {
				ritardoFiliera = getDayDifference(resolvedOnRdp, dueDateRdp);
			}
		}
		if (stato.status == filieraStatuses.CHIUSO_RITARDO) {
			if (!dueDateRdp) {
				ritardoFiliera = "DUEDATE RELEASE DI PROGETTO NON PRESENTE";
			} 
			else if (!resolvedOnRdp) {
				ritardoFiliera = getDayDifference(dueDateRdp, now);
			}
			else {
				ritardoFiliera = getDayDifference(resolvedOnRdp, dueDateRdp);
			}
		}
		console.log("Ritardo filiera giorni", ritardoFiliera);
	}
	var statiWi = {};
	statiWi.statoRdp = statusRdp;
	statiWi.statoRit = statusRit;
	statiWi.statoRser = statusRser;
	console.log("preparo help");
	console.log(statiWi);
	var html =  getFilieraHTML(title, formatDate(dataDispPrevista), formatDate(dataDispEffettiva), stato.html, 
				ritardoFiliera, wid, stato.macroFase, statiWi, stato.status);

	$("#eme-titolo-filiera").after(html);
}

function formatDate(dateStr){
	var d;
	if (dateStr) {
		d = moment(dateStr);
	}
	else {
		d = moment(null);
	}
	var out = "DATA NON PRESENTE";
	if (d.isValid()) {
		out = d.format("DD-MM-YYYY");
	}
	return out;
}

function getCustomField(item, cfId) {
	var value = null;
	if (item.hasOwnProperty("custom_fields")) {
		customFields = item.custom_fields;
		if ($.isArray(customFields.custom)) {
			for (var i = 0; i < customFields.custom.length; i++) {
				var cf = customFields.custom[i];
				if (cf.key == cfId) {
					value = cf.value;
				}
			}
		}
		else {
			if (customFields.custom.key == cfId) {
				value = customFields.custom.value;
			}
		}
	}
	return value;
}

//stabilisce lo stato del progetto demand
function getProgettoDemandStatus(pd) {
	var statiInLavorazione = ["nuovo", "rev_cdc", "rev_sm", "enunciato", "assegnato", "in_sviluppo"];
	var statiChiusi = ["chiuso"];
	var statiSospesi = ["sospeso"];
	var statiEsercizio = ["in_esercizio"];
	var dueDate = null;
	var resolvedOn = null;
	var dispEffettiva = null;

	if (pd.hasOwnProperty("due_date")) {
		dueDate = moment(pd.due_date);
	}
	if (pd.hasOwnProperty('resolved_on')) {
		resolvedOn = moment(pd.resolved_on);
	}
	var dataDispOk = getCustomField(pd, "data_dispok");
	if (dataDispOk != null) {
		dispEffettiva = moment(dataDispOk);
	}


	if (pd.hasOwnProperty("custom_fields")) {
		customFields = pd.custom_fields;
		if ($.isArray(customFields.custom)) {
			for (var i = 0; i < customFields.custom.length; i++) {
				var cf = customFields.custom[i];
				if (cf.key == 'data_dispok') {
					dispEffettiva = moment(cf.value);
				}
			}
		}
		else {
			if (customFields.custom.key == "data_dispok") {
				dispEffettiva = moment(customFields.custom.value);
			}
		}
	}

	var status = pd.status.id;
	var now = moment();
	console.log("dueDate", dueDate);
	console.log("resolvedOn", resolvedOn);
	console.log("dispEffettiva", dispEffettiva);
	console.log("status", status);

	//fase lavorazione
	if ($.inArray(status, statiInLavorazione) > -1) {
		if (resolvedOn == null && dueDate.isSameOrAfter(now, "day")) {
			return {
				status: pdStatuses.IN_LAVORAZIONE,
				html: "<span class='" + pdStatusesColor.IN_LAVORAZIONE + "'>" + pdStatuses.IN_LAVORAZIONE + "</span>"
			};
		}
		if (dueDate == null  && resolvedOn == null) {
			return {
				status: pdStatuses.IN_LAVORAZIONE_NON_PIANIFICATO,
				html: "<span class='" + pdStatusesColor.IN_LAVORAZIONE_NON_PIANIFICATO + "'>" + pdStatuses.IN_LAVORAZIONE_NON_PIANIFICATO + "</span>"
			};
		}
		if (resolvedOn == null && dueDate.isBefore(now, "day")) {
			return {
				status: pdStatuses.IN_RITARDO,
				html: "<span class='" + pdStatusesColor.IN_RITARDO + "'>" + pdStatuses.IN_RITARDO + "</span>"
			};
		}
	}

	//chiuso
	if ($.inArray(status, statiChiusi) > -1) {
		if (dueDate == null || dueDate.isAfter(resolvedOn, "day")) {  //scambio con resolvedOn.isSameOrBefore(dueDate)
			return {
				status: pdStatuses.CHIUSO,
				html: "<span class='" + pdStatusesColor.CHIUSO + "'>" + pdStatuses.CHIUSO + "</span>"
			};
		}
		if (dueDate.isSameOrBefore(resolvedOn, "day")) {  //contrario di resolvedOn.isAfter(dueDate, "day")
			return {
				status: pdStatuses.CHIUSO_RITARDO,
				html: "<span class='" + pdStatusesColor.CHIUSO_RITARDO + "'>" + pdStatuses.CHIUSO_RITARDO + "</span>"
			};
		}
	}

	//sospeso
	if ($.inArray(status, statiSospesi) > -1) {
		console.log("SOSPESO",$.inArray(status, statiSospesi));
		return {
			status: pdStatuses.SOSPESO,
			html: "<span class='" + pdStatusesColor.SOSPESO + "'>" + pdStatuses.SOSPESO + "</span>"
		};
	}

	//completato
	if ($.inArray(status, statiEsercizio) > -1) {
		if (dueDate == null || dispEffettiva.isSameOrBefore(dueDate, "day")) {
			return {
				status: pdStatuses.COMPLETATO,
				html: "<span class='" + pdStatusesColor.COMPLETATO + "'>" + pdStatuses.COMPLETATO + "</span>"
			};
		}
		if (dispEffettiva.isAfter(dueDate, "day")) {
			return {
				status: pdStatuses.COMPLETATO_RITARDO,
				html: "<span class='" + pdStatusesColor.COMPLETATO_RITARDO + "'>" + pdStatuses.COMPLETATO_RITARDO + "</span>"
			};
		}
	}
	return {
		status: pdStatuses.INVALID,
		html: "<span class='" + pdStatusesColor.INVALID + "'>" + pdStatuses.INVALID + "</span>"
	};
}

//stabilisce lo stato della filiera
function getFilieraStatus(rdp, rit, rser) {
	var statiInSviluppo = ["in_sviluppo", "in_compilazione", "in_test", "test_ko", "test_ok", "da_pubblicare", "go_integrazione", "non_conforme"];
	var statiInIntegrazione = ["in_integrazione", "archiviazione_release_esercizio"];
	var statiInFix = ["quickfix", "quickbuild"];
	var statiServizi = ["in_esercizio", "generazione_rns"]; //generazione_rns???
	var statiChiusi = ["annullato", "pubblico", "integrazione_ko", "in_esercizio_next", "compilazione_ko"];

	var now = moment();

	var dueDateRdp = null;
	var resolvedOnRdp = null;
	var statusRdp = null;
	if (rdp != null) {
		statusRdp = rdp.status.id;
		if (rdp.hasOwnProperty("due_date")) {
			dueDateRdp = moment(rdp.due_date);
		}
		if (rdp.hasOwnProperty('resolved_on')) {
			resolvedOnRdp = moment(rdp.resolved_on);
		}
	}

	console.log("dueDateRdp", dueDateRdp);
	console.log("resolvedOnRdp", resolvedOnRdp);
	console.log("statusRdp", statusRdp);

	var dueDateRit = null;
	var resolvedOnRit = null;
	var statusRit = null;
	var dataPrevistaFineIt; 
	var dataFineIt = null;
	if (rit != null) {
		statusRit = rit.status.id;
		if (rit.hasOwnProperty("due_date")) {
			dueDateRit = moment(rit.due_date);
		}
		if (rit.hasOwnProperty('resolved_on')) {
			resolvedOnRit = moment(rit.resolved_on);
		}
		var dataItEnd = getCustomField(rit, "data_it_end");
		if (dataItEnd != null) {
			dataPrevistaFineIt = moment(dataItEnd);
		}
		var fineIt = getCustomField(rit, "_fineIT");
		if (fineIt != null) {
			dataFineIt = moment(fineIt);
		}
	}
	console.log("dueDateRit", dueDateRit);
	console.log("resolvedOnRit", resolvedOnRit);
	console.log("dataPrevistaFineIt", dataPrevistaFineIt);
	console.log("dataFineIt", dataFineIt);
	console.log("statusRit", statusRit);

	var dueDateRser = null;
	var resolvedOnRser = null;
	var statusRser = null;
	if (rser != null) {
		statusRser = rser.status.id;
		if (rser.hasOwnProperty("due_date")) {
			dueDateRser = moment(rser.due_date);
		}
		if (rser.hasOwnProperty('resolved_on')) {
			resolvedOnRser = moment(rser.resolved_on);
		}
	}
	console.log("dueDateRser", dueDateRser);
	console.log("resolvedOnRser", resolvedOnRser);
	console.log("statusRser", statusRser);

	var out;
	//fase sviluppo
	if ($.inArray(statusRdp, statiInSviluppo) > -1) {
		out = {
				html: "<span class='" + filieraStatusesColor.IN_SVILUPPO + "'>" + filieraStatuses.IN_SVILUPPO + "</span>",
				status: filieraStatuses.IN_SVILUPPO,
				macroFase: macroFasi.SVILUPPO
			}
		if (dueDateRdp.isBefore(now, "day") && resolvedOnRdp == null) {
			out = {
				html: "<span class='" + filieraStatusesColor.IN_SVILUPPO_RITARDO + "'>" + filieraStatuses.IN_SVILUPPO_RITARDO + "</span>",
				status: filieraStatuses.IN_SVILUPPO_RITARDO,
				macroFase: macroFasi.SVILUPPO
			}
		}
		return out;
	}

	//fase IT
	if ($.inArray(statusRdp, statiInIntegrazione)> -1) {
		out = {
				html: "<span class='" + filieraStatusesColor.IN_INTEGRAZIONE + "'>" + filieraStatuses.IN_INTEGRAZIONE + "</span>",
				status: filieraStatuses.IN_INTEGRAZIONE,
				macroFase: macroFasi.IT
			}
		if (dataPrevistaFineIt.isBefore(now, "day") && dataFineIt == null) {
			out = {
				html: "<span class='" + filieraStatusesColor.IN_INTEGRAZIONE_RITARDO + "'>" + filieraStatuses.IN_INTEGRAZIONE_RITARDO + "</span>",
				status: filieraStatuses.IN_INTEGRAZIONE_RITARDO,
				macroFase: macroFasi.IT
			}
		}
		return out;
	}

	//fase fix
	if ($.inArray(statusRdp, statiInFix) > -1) {
		out = {
				html: "<span class='" + filieraStatusesColor.IN_SVILUPPO_FIX + "'>" + filieraStatuses.IN_SVILUPPO_FIX + "</span>",
				status: filieraStatuses.IN_SVILUPPO_FIX,
				macroFase: macroFasi.SVILUPPO
			}	
		if (dataPrevistaFineIt.isBefore(now, "day") && dataFineIt == null) {
			out = {
				html: "<span class='" + filieraStatusesColor.IN_SVILUPPO_FIX_RITARDO + "'>" + filieraStatuses.IN_SVILUPPO_FIX_RITARDO + "</span>",
				status: filieraStatuses.IN_SVILUPPO_FIX_RITARDO,
				macroFase: macroFasi.SVILUPPO
			}
		}
		return out;
	}

	//fase servizi
	if ($.inArray(statusRdp, statiServizi) > -1) {
		out = {
				html: "<span class='" + filieraStatusesColor.IN_SERVIZI + "'>" + filieraStatuses.IN_SERVIZI + "</span>",
				status: filieraStatuses.IN_SERVIZI,
				macroFase: macroFasi.SERVIZI
			}
		if (dueDateRser.isBefore(now, "day")) {
			out = {
				html: "<span class='" + filieraStatusesColor.IN_SERVIZI_RITARDO + "'>" + filieraStatuses.IN_SERVIZI_RITARDO + "</span>",
				status: filieraStatuses.IN_SERVIZI_RITARDO,
				macroFase: macroFasi.SERVIZI
			}
		}
		return out;
	}
	
	//fase chiuso
	if ($.inArray(statusRdp, statiChiusi) > -1) {
		out = {
				html: "<span class='" + filieraStatusesColor.CHIUSO + "'>" + filieraStatuses.CHIUSO + "</span>",
				status: filieraStatuses.CHIUSO,
				macroFase: macroFasi.CHIUSO
			}
		if (resolvedOnRdp.isAfter(dueDateRdp)) {
			out = {
				html: "<span class='" + filieraStatusesColor.CHIUSO_RITARDO + "'>" + filieraStatuses.CHIUSO_RITARDO + "</span>",
				status: filieraStatuses.CHIUSO_RITARDO,
				macroFase: macroFasi.CHIUSO
			}
		}
		return out;	
	}

	return {
		html: "<span class='" + filieraStatusesColor.INVALID + "'>" + filieraStatuses.INVALID + "</span>",
		status: filieraStatuses.INVALID,
		macroFase: macroFasi.INVALID
	}
}


function getDayDifference(a, b) {
	var from, to;
	if (a) {
		from = moment(a);
	}
	if (b) {
		to = moment(b);
	}
	else {
		b = moment();
	}
	var duration = moment.duration(from.diff(to));
	var d = Math.abs(duration.asDays());
	d = Math.trunc(d);
	return d;
}

function getProgettoDemandHTML(title, codiceRilascio, dataConsegnaPrevista, dataChiusura, status, description, wid, ritardo) {
	var str = "<h3><div id='eme-titolo-progetto-demand'>Progetto Demand</div></h3>";
	str += "<h4>";
	if (title.length > 50) {
		str += "<span id='captionSpan' data-full='" + title +"'>"+cutStringSize(title,50)+"</span><span id='readMoreSpan'>Leggi tutto...</span></h4>";
	} else {
		str += title +"</h4>";
	}
	str += "<table id='eme-progettodemand-details' class='table table-condensed'>";
	str +=	"<tr>";
	str +=	"<td class='caption'>Data di consegna prevista</td>";
	str +=	"<td>" + dataConsegnaPrevista + "<td>";
	str += "</tr>";
	str +=	"<tr>";
	str +=	"<td class='caption'>Data di chiusura effettiva</td>";
	str += 	"<td>" + dataChiusura + "</td>";
	str += "</tr>";
	if (ritardo) {
		str +=	"<tr>";
		str +=	"<td class='caption'>Quantificazione ritardo</td>";
		str += 	"<td><span class='eme-rosso'>" + ritardo + " giorni</span></td>";
		str += "</tr>";
	}
	str +=	"<tr>";
	str +=	"<td class='caption'>Stato</td>";
	
	str +=	"<td>" + status + "</td>";
	str += "</tr>";
	str += "<tr>";
	str += "<td class='caption'><span class='smallCodesLabelSpan'>Codice rilascio</span></td>"
	str += "<td> <span class='smallCodesFieldSpan'>" + codiceRilascio + "</span></td>";
    str += "</tr>";
    str +=	"<tr>";
	str += "<td class='caption'><span class='smallCodesLabelSpan'>ID rilascio contrattuale</span></td>";
	str += "<td><span class='smallCodesFieldSpan'>" + wid + "</span></td>";
	str +=	"</tr>";
	str +=	"<tr>";
	str +=	"<td/>";
	str +=	"</tr>";
	str +=	"<tr>";
	str += "<td class='caption' colspan='2'>Descrizione</td>";
	str += "</tr>";
	str += "<tr>";
	if (description.length > 100) { 
		str += "<td colspan='2'><span class='descriptionCaptionSpan' data-full='" + description +"'>"+cutStringSize(description,100)+" </span><span class='descriptionReadMoreSpan'>Leggi tutto...</span></td>";
	} else {
		str += "<td colspan = '2'>" + description +"</td>";
	}
	str +=	"</tr>";
	str += "</tr>";
	str += "</table>";
	return str;
}

function getFilieraHTML(title, dataDisponibilitaPrevista, dataDisponibilitaEffettiva, status, ritardoFiliera, wid, macroFase, statiWI, statoFiliera) {
	var str = "<div class='block'>";
	str += "<table class='table table-condensed eme-filiera-details'>";
	str +=	"<tr>";
	str +=	"<td class='caption'>Titolo</td>"
	if (title.length > 50 ){
		str +=	"<td class='highlight'><span class='filieraCaptionSpan' data-full='" + title +"'>"+cutStringSize(title,50)+" </span><span class='filieraReadMoreSpan'>Leggi tutto...</span></td>";
	} else {
		str +=	"<td class='highlight'>" + title +"</td>";
	}
	str += "</tr>";			
	str += "<tr>";
	str += "<td class='caption'>Data di disponibilita' prevista</td>";
	str += "<td>" + dataDisponibilitaPrevista+ "</td>";
	str += "</tr>";			
	str += "<tr>";
	str += "<td class='caption'>Data di disponibilita' effettiva</td>";
	str += "<td>" + dataDisponibilitaEffettiva+ "</td>";
	str += "</tr>";		
	if (ritardoFiliera) {
		str += "<tr>";
		str += "<td class='caption'>Quantificazione ritardo</td>";
		str += "<td><span class='eme-rosso'>" + ritardoFiliera+ " giorni</span></td>";
		str += "</tr>";
	}	
	str += "<tr>";
	str += "<td class='caption'>Stato</td>";
	var helpBtn = " <i tabindex='0' class='fa fa-question-circle eme-help-btn' aria-hidden='true' ";
	console.log("HELP");
	console.log(statiWI);
	helpBtn += "data-macrofase='"+ macroFase +"' ";
	helpBtn += "data-statordp='"+ statiWI.statoRdp +"' ";
	helpBtn += "data-statorit='"+ statiWI.statoRit +"' ";
	helpBtn += "data-statorser='"+ statiWI.statoRser +"' ";
	helpBtn += "data-ritardofiliera='"+ ritardoFiliera +"' ";
	helpBtn += "data-statofiliera='"+ statoFiliera +"' ";
	helpBtn += "></i>";
	str += "<td>" + status + helpBtn + "</td>";
	str += "</tr>";			
	str += "<tr>";
	str += "<td class='caption'><span class='smallCodesLabelSpan'>Id rilascio</span></td>";
	str += "<td><span class='smallCodesFieldSpan'>" + wid + "</span></td>";
	str += "</tr>";		
	str += "</table>";
	str += "</div>";
	return str;
}

function prepareHelpText() {
	$this = $(this);

	var macrofase = $this.data("macrofase");
	var statoRdp = $this.data("statordp"); 
	var statoRit = $this.data("statorit"); 
	var statoSer = $this.data("statorser"); 
	var ritardo = $this.data("ritardofiliera"); 
	var statoFiliera = $this.data("statofiliera");

	if (!statoRit) {
		statoRit = "NON PRESENTE";
	}
	if (!statoSer) {
		statoSer = "NON PRESENTE";
	}

	var text = helpText[statoFiliera];
	var content = text.replace("%statoReleaseProgetto%", statoRdp);
	content = content.replace("%statoReleaseIT%", statoRit);
	content = content.replace("%statoReleaseServizi%", statoSer);
	content = content.replace("%ritardo%", ritardo);
	return content;
}