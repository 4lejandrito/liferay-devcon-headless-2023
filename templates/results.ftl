<ol class="list-group" id="results">
	<span aria-hidden="true" class="loading-animation loading-animation-sm"></span>
</ol>

<template id="result">
	<li class="list-group-item" style="background-color: transparent !important; border-color: currentColor;">
		<div class="d-flex">
			<div class="flex-grow-1 font-weight-bold mr-3 name"></div>
			<div>
				<div class="badge badge-secondary votes"></div>
			</div>
		</div>
	</li>
</template>

<script>
	(async function getResults() {
		const options = await fetch("/o/c/options/?filter=options%2FexternalReferenceCode%20eq%20%27${ObjectEntry_externalReferenceCode.getData()}%27&pageSize=1000").then(res => res.json())
		const votes = await fetch("/o/c/votes/?aggregationTerms=r_votes_c_optionId&filter=votes%2Foptions%2FexternalReferenceCode%20eq%20%27${ObjectEntry_externalReferenceCode.getData()}%27&pageSize=1000").then(res => res.json())
		const results = options.items.map(option => ({
			votes: votes.facets?.[0]?.facetValues?.find(facet => facet.term === '' + option.id)?.numberOfOccurrences ?? 0,
			name: option.value
		})).sort((a, b) => b.votes - a.votes)
		const resultsNode = document.getElementById('results')
		const template = document.getElementById('result')
		resultsNode.innerHTML = ''
		results.forEach(result => {
			const node = template.content.cloneNode(true)
			node.querySelector('.name').innerText = result.name
			node.querySelector('.votes').innerText = result.votes
			resultsNode.append(node)
		})
	})()
</script>