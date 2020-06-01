/**
 * 
 */
const axios = require("axios");
const cheerio = require("cheerio");
const log = console.log;

const getHtml = function () {
  try {
    return  axios.get("https://music.bugs.co.kr/chart");
  } catch (error) {
    console.error(error);
  }
};

getHtml()
  .then(html => {
    let ulList = [];
    const $ = cheerio.load(html.data);
    const bodyList = $("table.list.trackList.byChart tbody").children("tr");

    log(bodyList.length);
    
    bodyList.each(function(i, elem) {
      ulList[i] = {
          rank: $(this).find("div.ranking strong").text(),
          album_title: $(this).find("a.album").text(),
          album_url: $(this).find("a.thumbnail").attr("href"),
          song_title: $(this).find("p.title a").text(),
          song_artist: $(this).find("td.left p.artist a").text()
      };
    });

    log(ulList.length);
    
    const data = ulList.filter(n => n.rank);
    return data;
  })
  .then(res => log(res));