/**
 * 
 */
const axios = require("axios");
const cheerio = require("cheerio");
const log = console.log;

const getHtml = function () {
  try {
    return  axios.get("https://www.melon.com/chart/index.htm");
  } catch (error) {
    console.error(error);
  }
};

getHtml()
  .then(html => {
    let ulList = [];
    const $ = cheerio.load(html.data);
    const bodyList = $("div.service_list_song.type02.d_song_list table tbody").children("tr.lst50");

    log(bodyList.length);
    
    bodyList.each(function(i, elem) {
      ulList[i] = {
          rank: $(this).find("div.wrap.t_center span.rank").text(),
          album_title: $(this).find("div.wrap a.image_typeAll").attr("title"),
          album_url: $(this).find("div.wrap a.image_typeAll").attr("href"),
          song_title: $(this).find("div.wrap div.wrap_song_info div.ellipsis.rank01 span a").text(),
          song_artist: $(this).find("div.wrap div.wrap_song_info div.ellipsis.rank02 span a").text()
      };
    });
    
    bodyList.each(function(i, elem){
    	ulList[i].album_url="https://www.melon.com/album/detail.htm?albumId="+ulList[i].album_url.substring(37,45);
    });
    
    log(ulList.length);
    
    const data = ulList.filter(n => n.rank);
    return data;
  })
  .then(res => log(res));