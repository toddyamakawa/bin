
// list.print()
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

function select(target) {
	return document.querySelectorAll(target);
}

