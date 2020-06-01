/**
 * 
 */
const axios = require("axios");
const cheerio = require("cheerio");
const log = console.log;

const getHtml = function () {
  try {
    return axios.get("https://www.nate.com/");
  } catch (error) {
    console.error(error);
  }
};

getHtml()
  .then(html => {
    let ulList = [];
    const $ = cheerio.load(html.data);
    
    const bodyList = $("div.isKeyword ol.isKeywordList").children("li");

    log(bodyList.length);
    
    bodyList.each(function(i, elem) {
      ulList[i] = {
          rank: $(this).find("span.num_rank").text(),
          text: $(this).find("a.ik span.txt_rank").text(),
          url: $(this).find("a.ik").attr("href")
      };
    });

    log(ulList.length);
    log(ulList);
    
    const data = ulList.filter(n => n.rank);
    return data;
  })
.then(res => console.log(res));

//url 안됨