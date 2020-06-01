/**
 * 
 */
const axios = require("axios");
const cheerio = require("cheerio");
const log = console.log;

const getHtml = function () {
  try {
    return  axios.get("https://www.genie.co.kr/chart/top200");
  } catch (error) {
    console.error(error);
  }
};

getHtml()
  .then(html => {
    let ulList = [];
    const $ = cheerio.load(html.data);
    const bodyList = $("div.newest-list div.music-list-wrap table.list-wrap tbody").children("tr.list");

    log(bodyList.length);
    
    bodyList.each(function(i, elem) {
      ulList[i] = {
          rank: $(this).find("td.number").text(),
          album_title: $(this).find("a.albumtitle.ellipsis").text(),
          album_url: $(this).find("a.cover").attr("onclick"),
          song_title: $(this).find("a.title.ellipsis").text(),
          song_artist: $(this).find("a.artist.ellipsis").text()
      };
    });

    bodyList.each(function(i, elem){
    	let temp = ulList[i].rank.indexOf("\n");
    	ulList[i].rank=ulList[i].rank.substring(0,temp);	
    	ulList[i].album_url="https://www.genie.co.kr/detail/albumInfo?axnm="+ulList[i].album_url.substring(18,26);
    	temp = ulList[i].song_title.lastIndexOf("\n");
    	ulList[i].song_title=ulList[i].song_title.substring(temp+49,ulList[i].song_title.length)
    });
    
    log(ulList.length);
    
    const data = ulList.filter(n => n.rank);
    return data;
  })
  .then(res => log(res));