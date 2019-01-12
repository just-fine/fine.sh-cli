template = "
<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"utf-8\">
  <meta content=\"ie=edge\" http-equiv=\"x-ua-compatible\">
  <link rel=dns-prefetch href=\"//fine.sh\">
  <link rel=preconnect href=\"//fine.sh\">
  <link rel=icon href=\"//cdn.jsdelivr.net/npm/@fine.sh/front/dist/favicon.ico\">
  <link rel=\"stylesheet\" href=\"//cdn.jsdelivr.net/npm/@fine.sh/themes@0.0.2/dist/plain.css\">
  <title>FINE_TITLE</title>
</head>
<script>window.fine_settings=FINE_INTERFACE</script>
<body>
<div id=\"app\"></div>
<script src=\"//cdn.jsdelivr.net/npm/@fine.sh/runtime@0.0.7/dist/run_time.js\" type=\"text/javascript\"></script>
</body>
</html>
"
module.exports = template
