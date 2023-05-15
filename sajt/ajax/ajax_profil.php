<?php
session_start();
require_once("../_obavezni.php");
$odgovor=array(
    "greska"=>"", 
    "uspeh"=>""
);
//Provera da li je korisnik ulogovan
if(!login()){
    //echo "<h1>Morate biti prijavljeni!!!</h1><br><a href='prijava.php'>Prijavite se</a></div>";
    $odgovor['greska']="Morate biti prijavljeni!!!";
    echo JSON_encode($odgovor, 256);
    exit();
}
$db=new Baza();
if(!$db->connect()) exit();

$akcija=$_GET['akcija'];
//Deaktivacija
if($akcija=="deaktiviraj"){
    $upit="UPDATE korisnici SET aktivan=0 WHERE id={$_SESSION['id']}";
    $db->query($upit);
    if($db->error())$odgovor['greska']=$db->error();
    else $odgovor['uspeh']="odjava.php";
}
//Brisanje
if($akcija=="obrisi"){
    $upit="UPDATE korisnici SET obrisan=1 WHERE id={$_SESSION['id']}";
    $db->query($upit);
    if($db->error())$odgovor['greska']=$db->error();
    else $odgovor['uspeh']="odjava.php";
}
//Lozinka
if($akcija=="promenaLozinke"){
    $lozinka=$_POST['lozinka'];
    $ponovo=$_POST['ponovo'];
    if($lozinka!="" && $ponovo!=""){
        if($lozinka==$ponovo){
            if(validanString($lozinka)){
                $upit="UPDATE korisnici SET lozinka='{$lozinka}' WHERE id={$_SESSION['id']}";
                $db->query($upit);
                if($db->error())$odgovor['greska']=$db->error();
            }
            else
                $odgovor['greska']="Lozinka sadrži nedozvoljene karaktere!!!!";
        }
        else
            $odgovor['greska']="Lozinke su različite!!!!";
    }
    else
        $odgovor['greska']="Svi podaci su obavezni!!!!";
}
//Podaci
if($akcija=="promenaPodataka"){
    $ime=$_POST['ime'];
    $prezime=$_POST['prezime'];
    if($ime!="" && $prezime!=""){
        $upit="UPDATE korisnici SET ime='{$ime}', prezime='{$prezime}' WHERE id={$_SESSION['id']}";
        $db->query($upit);
        if($db->error()==""){
            $_SESSION['podaci']="{$ime} {$prezime}";
            if($_FILES['avatar']['name']!="")
                @move_uploaded_file($_FILES['avatar']['tmp_name'], "../avatars/{$_SESSION['id']}.jpg");
           
        }else 
            $odgovor['greska']=$db->error();
        
    }
    else 
        $odgovor['greska']="Svi podaci su obavezni!!!!";
}

//Prikaz podataka
if($akcija=="prikaziKorisnika"){
    $upit="SELECT ime, prezime FROM korisnici WHERE id={$_SESSION['id']}"; 
    $rez=$db->query($upit);
    $red=$db->fetch_object($rez);
    $odgovor['ime']=$red->ime;
    $odgovor['prezime']=$red->prezime;
    $odgovor['slika']="avatars/_noavatar.jpg";
    if(file_exists("../avatars/{$_SESSION['id']}.jpg"))$odgovor['slika']="avatars/{$_SESSION['id']}.jpg";
}

echo JSON_encode($odgovor, 256);
?>