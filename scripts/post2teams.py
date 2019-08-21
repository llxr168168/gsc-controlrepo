#!/bin/env python
import json
import requests
import sys
import os

myurl="https://outlook.office.com/webhook/399c3961-0be6-4edf-ab84-bef4f54a43e7@44b79a67-d972-49ba-9167-8eb05f754a1a/IncomingWebhook/abccc6c3b5f94132a2b7acc920dbe6d4/3fd93c83-fda6-4bd8-8312-f15e20e9ae80"
myurl="https://outlook.office.com/webhook/cf7b8012-14cd-4389-b600-539c49589f4a@44b79a67-d972-49ba-9167-8eb05f754a1a/JenkinsCI/5451ce3e989745ce83be0864f0ba8135/3fd93c83-fda6-4bd8-8312-f15e20e9ae80"
mytitle=str(sys.argv[1])
mybody=str(sys.argv[2])
myurlpost=str(os.environ["JOB_URL"])
myurlpost=myurlpost.replace("https://linuxjnks.rancher.sherwin/","https://gpojnks.rancher.sherwin.com/")
myjson={
    "@context": "https://schema.org/extensions",
    "@type": "MessageCard",
    "themeColor": "0072C6",
    "title": mytitle,
    "text": mybody,
    "potentialAction": [
        {
            "@type": "OpenUri",
            "name": "More info",
            "targets": [
                {
                    "os": "default",
                    "uri": myurlpost
                }
            ]
        }
    ]
}

response = requests.post(myurl,  json=myjson)
myresp = response.json()
print myresp

if str(myresp)=="1":
  print "Submitted card successfully."
else:
  print "Could not submit card. Error was: "+str(myresp)
