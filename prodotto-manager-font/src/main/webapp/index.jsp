<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>

<script src="jquery-1.7.1.min.js" type="text/javascript"></script>

<html>
  <body>
	<div id = "loadpage"></div>
	<script>
	    var b = navigator.userAgent.indexOf( "MSIE" );
	
	    if ( b != -1 ) {
		      if ( navigator.userAgent.substring( b + 5 , b + 7 ) != "11" ) {
		    	  $( "#loadpage" ).load( "index10.jsp" );
		      } else {
		    	  $( "#loadpage" ).load( "index11.jsp" );
		      }
	      } else {
	    	  $( "#loadpage" ).load( "index11.jsp" );
	    }
	</script>
  </body>
</html>
