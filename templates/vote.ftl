<#assign
	poll = restClient.get("/c/polls/by-external-reference-code/${ObjectEntry_externalReferenceCode.getData()}?nestedFields=options")
/>

<form class="d-flex flex-column" id="vote-form">
	<select class="form-control mb-4" id="option-select">
		<#list poll.options as option>
			<option value="${option.externalReferenceCode}">
				${option.value}
			</option>
		</#list>
	</select>

	<button class="btn btn-nm btn-primary">
	  Submit vote
	</button>
</form>

<script>
	const select = document.getElementById('option-select')
	document.getElementById('vote-form').addEventListener('submit',
		function(e) {
			e.preventDefault();
			fetch('/o/c/votes', {
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					name: "guest",
					r_votes_c_optionERC: select.options[select.selectedIndex].value
				}),
				method: 'POST'
			}).then(() => window.location.href = '/results')
		}
	)
</script>