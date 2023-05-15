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
//prijava
if($akcija=="prijava"){
    $email=$_POST['email'];
    $lozinka=$_POST['lozinka'];
    if($email!="" and $lozinka!=""){
        if(validanString($email) and validanString($lozinka)){
            $upit="SELECT * FROM korisnici WHERE email='{$email}'";
            $rez=$db->query($upit);
            if($db->num_rows($rez)==1){
                $red=$db->fetch_object($rez);
                if($red->aktivan==1){
                    if($red->obrisan==0){
                        if($lozinka==$red->lozinka){
                            $_SESSION['id']=$red->id;
                            $_SESSION['podaci']=$red->ime." ".$red->prezime;
                            $_SESSION['email']=$red->email;
                            $_SESSION['status']=$red->status;
                            if(isset($_POST['zapamti'])){
                                setcookie("id", $_SESSION['id'], time()+86400, "/");
                                setcookie("podaci", $_SESSION['podaci'], time()+86400, "/");
                                setcookie("email", $_SESSION['email'], time()+86400, "/");
                                setcookie("status", $_SESSION['status'], time()+86400, "/");
                            }
                            Log::upisi("../logovi/".date("Y-m-d")."_logovanja.log", "Uspešna prijava korisnika '{$_SESSION['podaci']}'");
                            $odgovor['uspeh']="index.php";
                        }
                        else{
                            $odgovor['greska'] =Poruka::greska("Pogrešna lozinka za korisnika '{$email}'");
                            Log::upisi("../logovi/".date("Y-m-d")."_logovanja.log", "Pogrešna lozinka za korisnika '{$email}'");
                        }
                            
                    }else{
                        $odgovor['greska'] = Poruka::info("Korisnik '{$email}' je obrisao svoj profil!!!");
                        Log::upisi("../logovi/".date("Y-m-d")."_logovanja.log", "Korisnik '{$email}' je obrisao svoj profil");
                    }
                        
                }else{
                    $odgovor['greska'] = Poruka::info("Korisnik '{$email}' postoji, ali je neaktivan!!!");
                    Log::upisi("../logovi/".date("Y-m-d")."_logovanja.log", "Korisnik '{$email}' postoji, ali je neaktivan"); 
                }
                    
            }
            else{
                $odgovor['greska'] = Poruka::greska("Ne postoji korisnik '{$email}'");
                Log::upisi("../logovi/".date("Y-m-d")."_logovanja.log", "Ne postoji korisnik '{$email}'"); 
            }
                
        }
        else{
            $odgovor['greska'] = Poruka::greska("Podaci sadrže nedozvoljene karaktere!!!");
            Log::upisi("../logovi/".date("Y-m-d")."_logovanja.log", "Podaci sadrže nedozvoljene karaktere. '{$email}', '{$lozinka}', {$_SERVER['REMOTE_ADDR']}"); 
        }
            
    }
    else
        $odgovor['greska'] = Poruka::greska("Svi podaci su obavezni!!!");
}

if($akcija=="registracija"){
    
}

if($akcija=="lozinka"){
    
}

echo JSON_encode($odgovor, 256);
?>