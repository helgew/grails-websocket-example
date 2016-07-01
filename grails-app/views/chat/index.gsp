<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />

<asset:javascript src="application" />
<asset:javascript src="spring-websocket" />

<script type="text/javascript">
	$(function() {
	    var url = "${createLink(uri: '/stomp')}";
	    var socket = new SockJS(url);
	    var client = Stomp.over(socket);
	    var headers = {ack: 'client'};
		client.connect(headers, function() {
			client.subscribe("/topic/hello", function(message) {
				$("#helloDiv").append(message.body);
				message.ack();
			}, function(message) {
				console.log(message)
			});
		});

		$("#helloButton").click(function() {
			client.send("/app/hello", {}, JSON.stringify("world"));
		});
	});
</script>
</head>
<body>
	<button id="helloButton">hello</button>
	<div id="helloDiv"></div>
</body>
</html>