<?php
    session_start();
    require_once("_obavezni.php");
    Log::upisi("logovi/".date("Y-m-d")."_logovanja.log", "Odjava korisnika '{$_SESSION['podaci']}'"); 
    session_unset();
    session_destroy();
    header("Location:index.php");
?>