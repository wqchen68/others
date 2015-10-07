rm(list=ls())
library(XML)
library(RCurl)

data = NULL
html0 <- readLines('http://www.319papago.idv.tw/lifeinfo/7-11/7-11-00.html',warn=F,encoding = "UTF-8") #首頁
pagetree <- htmlTreeParse(html0, useInternalNodes = TRUE, encoding='UTF-8')
url.list <- xpathSApply(pagetree, "//table[@width='746']/tr/td/a", xmlAttrs) #解析html

for (i in 17:length(url.list)){ #第一層：縣市
  
  urli = paste0('http://www.319papago.idv.tw/lifeinfo/7-11/',url.list[i],"")
  htmli <- readLines(urli, warn=F, encoding = "UTF-8")
  pagetree <- htmlTreeParse(htmli, useInternalNodes = TRUE, encoding='UTF-8')
  urli.list <- xpathSApply(pagetree, "//table[@width='728']//td[@height='33']/a", xmlAttrs)
  
  for (j in 1:length(urli.list)){ #第二層：鄉鎮市區
    urlj = paste0('http://www.319papago.idv.tw/lifeinfo/7-11/',urli.list[j],"")
    htmlj <- readLines(urlj, warn=F, encoding = "UTF-8")
    pagetree <- htmlTreeParse(htmlj, useInternalNodes = TRUE, encoding='UTF-8')
    row <- xpathSApply(pagetree, "//td[@height='33']", xmlValue) #原本可以抓 tr[@height='22']
    row = row[2:length(row)] #因為表格不統一，所以一律抓height='33'，再排掉第一個
    if (length(row) < 4){
      row <- xpathSApply(pagetree, "//table[@width='728']/tr/td", xmlValue) #為了台東縣長濱鄉的bug
      row = row[5:8] #http://www.319papago.idv.tw/lifeinfo/7-11/7-11-962.html
    }
    if (nchar(row[2]) != 1){ #偏遠地區，沒有門市：http://www.319papago.idv.tw/lifeinfo/7-11/7-11-211.html
                             #花蓮卓溪鄉的bug     http://www.319papago.idv.tw/lifeinfo/7-11/7-11-982.html
      data = rbind(data,t(matrix(row,4,)))
    }
  }
}


