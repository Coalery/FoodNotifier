## JsonFormat

### Get Method

|Method|Path|Processing|Input|Success Output|Fail Output|
|:---:|---|---|---|---|---|
|get|/barcode|get|barcode|{ "status" : true, "info" : json }|{ "status" : false, "info" : json }|
|get|/user|get|user id|{ "status" : true, "info" : json }|{ "status" : false, "info" : json }|
|get|/userinfo|scan|name, age, gender, job|{ "status" : true, "info" : json }|{ "status" : false, "info" : {} }|
|get|/recipe|scan|recipe ingredient|{ "result" : json[] }|{ "result" : [] }|
|get|/outofdatefoods|scan|user id|{ "result" : json[] }|{ "result" : [] }|

> [] : Empty Array

> {} : Empty Json Object

<br>

### Post Method

|Method|Path|Processing|Input|Success Output|Fail Output|
|:---:|---|---|---|---|---|
|post|/adduser|put|name, age, gender, job|{ "status" : true, "uid" : String, "info" : json }|{ "status" : false, "info" : json }|
|post|/addfood|put|user id, barcode, registerDateTime|{ "status" : true, "fid" : String, "info" : json }|{ "status" : false, "info" : json }|