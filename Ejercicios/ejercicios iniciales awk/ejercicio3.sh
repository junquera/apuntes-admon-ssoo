find .. -type f -exec ls -l {} \; | awk '{print $9" -> "$5}'

