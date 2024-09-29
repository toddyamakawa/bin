
// =============================================================================
// ARRAY
// =============================================================================
// array.print()
Array.prototype.print = function() {
	this.forEach((item, index) => {
		//console.log(`${index}: ${item}`);
		console.log(item);
	});
};

// list.uniq()
Array.prototype.uniq = function() {
	return [...new Set(this)]
};

// Select elements
function select(target) {
	return document.querySelectorAll(target);
}


// =============================================================================
// STRING
// =============================================================================
// Basename of URL
function basename(url) {
  return url.substring(url.lastIndexOf('/') + 1);
}

// =============================================================================
// OTHER
// =============================================================================
// Sleep
function sleep(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
}

// Download blob
function download_blob(blob_url) {
	console.log('Downloading blob:', blob_url);
	fetch(blob_url)
		.then(response => response.blob())
		.then(blob => {
			const url = URL.createObjectURL(blob);
			const a = document.createElement('a');
			a.href = url;
			filename = 'blob-' + basename(blob_url);
			a.download = filename;
			document.body.appendChild(a);
			a.click();
			a.remove();
			URL.revokeObjectURL(url);
		})
		.catch(console.error);
}

