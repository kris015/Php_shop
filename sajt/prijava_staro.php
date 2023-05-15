<?php
session_start();
require_once("_obavezni.php");
//$db=konekcija();
$db=new Baza();
if(!$db->connect()) exit();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body>
    <div class="container">
        <!--HEADER-->
        <?php require_once("_header.php");?>
        <!--GORNJI MENI-->
        <?php require_once("_gornjimeni.php");?>
        
        <div class="row">
            <!--GLAVNI SADRŽAJ-->
            <div class="col-9">
                <h2>STRANICA ZA PRIJAVU</h2>
                <hr>
                
                <div style="width:500px">
                    <form action="prijava.php" method="post">
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">Email adresa</label>
                            <input type="email" class="form-control" name="email" aria-describedby="emailHelp">
                            
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Lozinka</label>
                            <input type="password" class="form-control" name="lozinka">
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" name="zapamti">
                            <label class="form-check-label" for="exampleCheck1">Zapamti me na ovom uređaju</label>
                        </div>
                        <button type="submit" class="btn btn-primary mb-3">Prijavi se</button>
                    </form>
                    <?php
                        if(isset($_POST['email']) and isset($_POST['lozinka'])){
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
                                                    Log::upisi("logovi/".date("Y-m-d")."_logovanja.log", "Uspešna prijava korisnika '{$_SESSION['podaci']}'");
                                                    header("location:index.php");
                                                }
                                                else{
                                                    echo Poruka::greska("Pogrešna lozinka za korisnika '{$email}'");
                                                    Log::upisi("logovi/".date("Y-m-d")."_logovanja.log", "Pogrešna lozinka za korisnika '{$email}'");
                                                }
                                                    
                                            }else{
                                                echo Poruka::info("Korisnik '{$email}' je obrisao svoj profil!!!");
                                                Log::upisi("logovi/".date("Y-m-d")."_logovanja.log", "Korisnik '{$email}' je obrisao svoj profil");
                                            }
                                                
                                        }else{
                                            echo Poruka::info("Korisnik '{$email}' postoji, ali je neaktivan!!!");
                                            Log::upisi("logovi/".date("Y-m-d")."_logovanja.log", "Korisnik '{$email}' postoji, ali je neaktivan"); 
                                        }
                                            
                                    }
                                    else{
                                        echo Poruka::greska("Ne postoji korisnik '{$email}'");
                                        Log::upisi("logovi/".date("Y-m-d")."_logovanja.log", "Ne postoji korisnik '{$email}'"); 
                                    }
                                        
                                }
                                else{
                                    echo Poruka::greska("Podaci sadrže nedozvoljene karaktere!!!");
                                    Log::upisi("logovi/".date("Y-m-d")."_logovanja.log", "Podaci sadrže nedozvoljene karaktere. '{$email}', '{$lozinka}', {$_SERVER['REMOTE_ADDR']}"); 
                                }
                                    
                            }
                            else
                                echo Poruka::greska("Svi podaci su obavezni!!!");
                        }
                    ?>
                </div>
                <!--REGISTRACIJA KORISNIKA-->
                <hr>
                <h4>Registracija korisnika</h4>
                <div style="width:500px">
                    <form action="prijava.php" method="post">
                        <div class="mb-3">
                            <label for="ime" class="form-label">Unesite ime</label>
                            <input type="text" class="form-control" name="ime">
                        </div>
                        <div class="mb-3">
                            <label for="prezime" class="form-label">Prezime</label>
                            <input type="text" class="form-control" name="prezime" >
                            
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email adresa</label>
                            <input type="email" class="form-control" name="email">
                        </div>
                        <button type="submit" class="btn btn-primary mb-3">Registruj se</button>
                    </form>
                    <?php
                        if(isset($_POST['ime']) and isset($_POST['prezime']) and isset($_POST['email'])){
                            $ime=$_POST['ime'];
                            $prezime=$_POST['prezime'];
                            $email=$_POST['email'];
                            if($ime!="" and $prezime!="" and $email!=""){
                                $vreme=time();
                                $lozinka=generisiLozinku();
                                $upit="INSERT INTO korisnici (ime, prezime, email,  status, lozinka, registrovan) VALUES ('{$ime}', '{$prezime}', '{$email}', 'Korisnik', '".$lozinka."', {$vreme})";
                                echo $upit;
                                $db->query($upit);
                                // The message
                                $message = "Dobrodošli<br>Vaše korisničko ime je: {$email}<br>A vaša lozinka je: {$lozinka}<br>";
                                $message.="<a href='http://localhost/g1/aphp/p5/sajt/potvrdaRegistracije.php?email={$email}&broj={$vreme}' target='_blank'>Link za potvrdu mejla</a>";
                                echo $message."<br>";
                                // In case any of our lines are larger than 70 characters, we should use wordwrap()
                                $message = wordwrap($message, 70, "\r\n");

                                // Send
                                mail("{$email}", 'Potvrda registracije', $message);
                            }else
                                echo Poruka::greska("Svi podaci su obavezni!!!");
                        }
                    ?>
                </div>
            </div>
            <!--DESNI MENI-->
            <?php //require_once("_desnimeni.php");?>
        </div>

        <!--FUTER-->
        <?php require_once("_footer.php");?>

    </div>
</body>
</html>