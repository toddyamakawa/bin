
function get_images() {
	let divs = select('div.img.highres');
	let styles = [...divs].map(div => div.getAttribute('style'));
	let urls = [...styles].map(style => {match = style.match(/url\("(.*)"\)/); return match ? match[1] : ''});
	return urls;
}

function create_update_images() {
	let all_urls = [];
	return function() {
		let urls = get_images();
		all_urls = all_urls.concat(urls);
		all_urls = all_urls.sort().uniq();
		all_urls.print();
		console.log(all_urls.length);
		return all_urls;
	};
};
const update_images = create_update_images();
update_images();

// Listen for keydown events
document.addEventListener('keydown', (event) => {
	if(event.key === 'b') {
		// Prevent the default action if needed
		event.preventDefault();
		update_images();
	}
});

images = update_images();
images.forEach((item, index) => {
	setTimeout(() => {
		download_blob(item);
	}, index * 1000); // Delay each item by index * 1000 ms (1 second)
});

