#!/usr/bin/env python
# -*- coding: UTF-8 -*-


# pip install beautifulsoup4
import requests
from bs4 import BeautifulSoup
page = requests.get("https://www.google.co.kr/search?q=query_term")
soup = BeautifulSoup(page.content)
import re
links = soup.findAll("a")
for link in links: 
    if link['href'].startswith('/url?q='): 
            print (link['href'].replace('/url?q=',''))
#for link in  soup.find_all("a",href=re.compile("(?<=/url\?q=)(htt.*://.*)")):
#    print(re.split(":(?=http)",link["href"].replace("/url?q=","")))
