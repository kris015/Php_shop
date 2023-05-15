<?php
session_start();
require_once("../_obavezni.php");
$odgovor=array(
    "greska"=>"", 
    "uspeh"=>""
);
$db=new Baza();
if(!$db->connect()) exit();

$akcija=$_GET['akcija'];

if($akcija=="dodajProizvod"){
    $idProizvoda=$_POST['idProizvoda'];
    $upit="INSERT INTO korpa (korisnik_id, proizvod_id) VALUES ({$_SESSION['id']}, {$idProizvoda})";
    $db->query($upit);
    if($db->error())$odgovor['greska']=$db->error();
    else $odgovor['uspeh']="Uspešno dodat proizvod u korpu";
}

if($akcija=="prebrojProizvode"){
    $upit="SELECT * FROM pogledkorpa WHERE korisnik_id={$_SESSION['id']} and kupljen=0";
    $rez=$db->query($upit);
    $odgovor['uspeh']=$db->num_rows($rez);
}

echo JSON_encode($odgovor, 256);
?>