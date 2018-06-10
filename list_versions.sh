 #!/bin/bash
 # Releases list doesn't list all versions. We assume each PC Version comes with a new eco-server. So pick your pain.
 curl -sL https://s3-us-west-2.amazonaws.com/eco-releases/ |grep -Po "(?<=<Key>)EcoPC_v(.*?)+\.zip(?=<\/Key>)"