<?php
  $config = [
     "server"     => "127.0.0.1:3306",
     "username"   => "root",
     "password"   => "password",
     "file"       => "log"
  ];
  header('Content-type: application/json');
  $link = new mysqli($config['server'],$config['username'],$config['password']);
  if ($link->connect_errno) {
    http_response_code(503);
    ob_start();
    printf("Connect failed with: %s : %s\n", $link->connect_errno, $link->connect_error);
    echo('{ "status": "Unable to connect" }');
    $htmlStr = ob_get_contents();
    ob_end_clean();
    file_put_contents($config['file'], $htmlStr);
  }
  else {
    http_response_code(200);
    ob_start();
    echo('{ "status": "Connection successful." }');
    $htmlStr = ob_get_contents();
    ob_end_clean();
    file_put_contents($config['file'], $htmlStr);
  }
?>
