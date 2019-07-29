Configuration MyWebServerCOnfiguration {
    # Parameter help description
    #add other comment
    #add new comment
    param([string]$computername = "$env:COMPUTERNAME")
    Node $computername {
        WindowsFeature WebServer {
            Ensure = "present"
            Name   = "Web-Server"
        }
        WindowsFeature IISTools {
            Ensure    = "present"
            Name      = "Web-Mgmt-Console"
            DependsOn = "[WindowsFeature]WebServer"
        }
        File IISContent {
            Ensure = "Present"
            DestinationPath = "C:\inetpub\wwwroot\iisstart.htm"
            Recurse = $true
            Contents = "<!DOCTYPE html>
<html>
<head>
    <meta charset=`"utf-8`" />
    <meta http-equiv=`"X-UA-Compatible`" content=`"IE=edge`">
    <title>Start Page</title>
    <meta name=`"viewport`" content=`"width=device-width, initial-scale=1`">
    <link rel=`"stylesheet`" type=`"text/css`" media=`"screen`" href=`"main.css`" />
    <script src=`"main.js`"></script>
</head>
<body>
    Hello, Everybody from $($($computername).ToUpper())
</body>
</html>"
            DependsOn = "[WindowsFeature]WebServer"
        }
    }

}
MyWebServerCOnfiguration