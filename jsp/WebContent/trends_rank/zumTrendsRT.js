/**
 * 
 */
const axios = require("axios");
const cheerio = require("cheerio");
const log = console.log;

const getHtml = function () {
  try {
    return  axios.get("http://issue.zum.com/daily/20200529#!/1");
  } catch (error) {
    console.error(error);
  }
};

getHtml()
  .then(html => {
    let ulList = [];
    const $ = cheerio.load(html.data);
    const bodyList = $("div.inner ul.ranking_list").children("li.inner_cont");

    log(bodyList.length);
    
    bodyList.each(function(i, elem) {
      ulList[i] = {
          rank: $(this).find("a.txt.daily-keyword span.num").text(),
          text: $(this).find("a.txt.daily-keyword span.word").text(),
          url: $(this).find("a.btn_search").attr("href")
      };
    });

    log(ulList.length);
    log(ulList);
    
    const data = ulList.filter(n => n.rank);
    return data;
  })
  .then(res => log(res));