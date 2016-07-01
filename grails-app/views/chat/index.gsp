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
			client.subscribe("/queue/hello", function(message) {
				$("#helloDiv").append(message.body);

				// ack means ack, i.e. message removed from queue, no re-delivery
				// message.ack();

				// nack means reject, i.e. message stays queued and is re-delivered immediately
				// message.nack();

				// do nothing means message stays queued and is re-delivered on next subscription

			}, headers);
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