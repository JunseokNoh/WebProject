/**
 * 
 */
const axios = require("axios");
const cheerio = require("cheerio");
const log = console.log;

const getHtml = function () {
	try{
		return axios.get("https://www.naver.com/");
	} catch(error){
		console.error(error);
	}
};

getHtml().then(html => {
	let ulList = [];
	const $ = cheerio.load(html.data);
	log(html.data);
	
	const bodyList = $("div.ly_realtime div.realtime_area ul.list_realtime.NM_RTK_VIEW_list_content").children("li.realtime_item.keyword_on");
	
	log(bodyList.length);
	
	bodyList.each(function(i, elem){
		ulList[i] = {
				title: $(this).find('a.link_keyword span.keyword').text(),
				url: $(this).find('a.link_keyword').attr('href')
		};
	});
	
	const data = ulList.filter(n => n.title);
	return data;
} ).then(res => log(res));

//url 안됨