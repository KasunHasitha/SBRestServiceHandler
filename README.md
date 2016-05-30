# SBRestServiceHandler
iOS Objective C -   one wrapper class for all the restful web services in the App

##############################################################################################################
Hi guys,

This is a simple pattern that developers can call multiple(all in the app) restful servises using one wrapper class

TESTING

1.set copy the files to your project
2.set UrlString.String file as your api

 ex- "webservice" = "http//:someYourServer:port/";

    replace key "login" using your own "key""

      "key" = "last/part/endpoint"

when it use sould look like - http//:someYourServer:port/last/part/endpoint

3.Set the sample view controller methods and requist using the same "key"

4.put
   [self makeRequest];

in viewDidLoad or a place you want to call the method

5.check the log you can see the reponces are catched my getResponce method

Thank You.

#####################################################
