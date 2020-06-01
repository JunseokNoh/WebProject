/**
 * 
 */
const axios = require("axios");
const cheerio = require("cheerio");
const log = console.log;

const getHtml = function () {
  try {
    return  axios.get("https://www.billboard.com/charts/hot-100");
  } catch (error) {
    console.error(error);
  }
};

getHtml()
  .then(html => {
    let ulList = [];
    const $ = cheerio.load(html.data);
    const bodyList = $("div.chart-list.container ol.chart-list__elements").children("li.chart-list__element.display--flex");

    log(bodyList.length);
    
    bodyList.each(function(i, elem) {
      ulList[i] = {
          rank: $(this).find("span.chart-element__rank__number").text(),
          song_title: $(this).find("span.chart-element__information__song.text--truncate.color--primary").text(),
          song_artist: $(this).find("span.chart-element__information__artist.text--truncate.color--secondary").text()
      };
    });

    log(ulList.length);
    
    const data = ulList.filter(n => n.rank);
    return data;
  })
  .then(res => log(res));

//url 없음