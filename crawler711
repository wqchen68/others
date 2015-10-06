rm(list=ls())
library(XML)
library(RCurl)

data = NULL
html0 <- readLines('http://www.319papago.idv.tw/lifeinfo/7-11/7-11-00.html',warn=F,encoding = "UTF-8")
pagetree <- htmlTreeParse(html0, useInternalNodes = TRUE, encoding='UTF-8')
url.list <- xpathSApply(pagetree, "//table[@width='746']/tr/td/a", xmlAttrs)

for (i in 1:length(url.list)){
  
  urli = paste0('http://www.319papago.idv.tw/lifeinfo/7-11/',url.list[i],"")
  htmli <- readLines(urli, warn=F, encoding = "UTF-8")
  pagetree <- htmlTreeParse(htmli, useInternalNodes = TRUE, encoding='UTF-8')
  urli.list <- xpathSApply(pagetree, "//table[@width='728']//td[@height='33']/a", xmlAttrs)
  
  for (j in 1:length(urli.list)){
    urlj = paste0('http://www.319papago.idv.tw/lifeinfo/7-11/',urli.list[j],"")
    htmlj <- readLines(urlj, warn=F, encoding = "UTF-8")
    pagetree <- htmlTreeParse(htmlj, useInternalNodes = TRUE, encoding='UTF-8')
    row <- xpathSApply(pagetree, "//td[@height='33']", xmlValue)
    row = row[2:length(row)]
    data = rbind(data,t(matrix(row,4,)))
  }
}
