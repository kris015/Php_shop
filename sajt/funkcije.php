<?php
function konekcija(){
    $db=@mysqli_connect("localhost", "root", "", "g1");
    if(!$db){
        echo "Došlo je do greške prilikom konekcije na bazu!!!<br>";
        echo mysqli_connect_errno().": ".mysqli_connect_error();
        return false;
    }
    mysqli_query($db, "SET NAMES utf8");
    return $db;
}
function validanString($str){
    if(strlen($str)<4)return false;
    $nedozvoljeni=array("=", " ", "(", ")", "*", "+");
    foreach($nedozvoljeni as $v)
        if(strpos($str, $v)!==false)return false;
    return true;
}

/*function poruka($str, $opcija="greska"){
    if($opcija=="greska")$klasa="danger";
    if($opcija=="uspeh")$klasa="success";
    if($opcija=="info")$klasa="primary";
    return "<div class='alert alert-{$klasa}' role='alert'>{$str}</div>";
}*/

function statistika($db, $tekst=NULL){
    $upit="INSERT INTO statistika (ipadresa, stranica, parametri, tekst) values('{$_SERVER['REMOTE_ADDR']}', '{$_SERVER['SCRIPT_NAME']}', '{$_SERVER['QUERY_STRING']}', '{$tekst}')";
    $db->query($upit);
    if($db->error())echo "GREŠKA!!!!<br>".$db->error();
}

function pogledan($db, $id){
    $upit="UPDATE proizvodi SET pogledan=pogledan+1 WHERE id={$id}";
    $db->query($upit);
    if($db->error())echo "GREŠKA!!!!<br>".$db->error();
}

function login(){
    if(isset($_SESSION['id']) and isset($_SESSION['podaci'])) return true;
    else if(isset($_COOKIE['id']) and isset($_COOKIE['podaci'])){
        $_SESSION['id']=$_COOKIE['id'];
        $_SESSION['podaci']=$_COOKIE['podaci'];
        $_SESSION['email']=$_COOKIE['email'];
        $_SESSION['status']=$_COOKIE['status'];
        return true;
    }
    
    return false;
}

function generisiLozinku(){
    $malaSlova="abcdefgh";
    $velikaSlova="ABCDEFGH";
    $brojevi="12345567890";
    $spec="._%!@";
    $lozinka=$malaSlova[mt_rand(0, strlen($malaSlova)-1)].$malaSlova[mt_rand(0, strlen($malaSlova)-1)];
    $lozinka.=$spec[mt_rand(0, strlen($spec)-1)];
    $lozinka.=$velikaSlova[mt_rand(0, strlen($velikaSlova)-1)].$velikaSlova[mt_rand(0, strlen($velikaSlova)-1)];
    $lozinka.=$brojevi[mt_rand(0, strlen($brojevi)-1)].$brojevi[mt_rand(0, strlen($brojevi)-1)];
    return $lozinka;
}
?>