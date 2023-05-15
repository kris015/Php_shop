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
                    
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">Email adresa</label>
                            <input type="email" class="form-control" name="email" id="email" aria-describedby="emailHelp">
                            
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Lozinka</label>
                            <input type="password" class="form-control" name="lozinka" id="lozinka">
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" name="zapamti">
                            <label class="form-check-label" for="exampleCheck1">Zapamti me na ovom uređaju</label>
                        </div>
                        <button type="button" class="btn btn-primary mb-3" onclick="prijava()">Prijavi se</button> <br>
                        <div id="divOdgovor"></div>
                        <button type="button" class="btn btn-success mb-3 btn-sm" onclick="prikaziRegistraciju()">Registruj se</button>
                        <button type="button" class="btn btn-success mb-3 btn-sm" onclick="prikaziLozinku()">Zaboravljena lozinka</button>
                    
                    
                </div>
                <!--REGISTRACIJA KORISNIKA-->
                <hr>
                <div style="width:500px;display:none" id="divRegistracija">
                        <div class="mb-3">
                            <label for="ime" class="form-label">Unesite ime</label>
                            <input type="text" class="form-control" name="ime">
                        </div>
                        <div class="mb-3">
                            <label for="prezime" class="form-label">Prezime</label>
                            <input type="text" class="form-control" name="prezime" >
                            
                        </div>
                        <div class="mb-3">
                            <label for="remail" class="form-label">Email adresa</label>
                            <input type="email" class="form-control" name="remail" id="remail">
                        </div>
                        <button class="btn btn-primary mb-3" onclick="registracija()">Registruj se</button>
                    
                </div>
                <div style="width:500px;display:none" id="divLozinka">
                        <div class="mb-3">
                            <label for="zlemail" class="form-label">Email adresa</label>
                            <input type="email" class="form-control" name="zlemail" id="zlemail">
                        </div>
                        <button class="btn btn-primary mb-3" onclick="lozinka()">Pošalji lozinku</button>
                    
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

<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
<script>
    $(function(){

    })
    function prikaziRegistraciju(){
        $("#divLozinka").hide();
        $("#divRegistracija").show(500);
    }
    function prikaziLozinku(){
        $("#divLozinka").show(500);
        $("#divRegistracija").hide();
    }
    function prijava(){
        let email=$("#email").val();
        let lozinka=$("#lozinka").val();
        $.post("ajax/ajax_prijava.php?akcija=prijava", {email: email, lozinka: lozinka}, function(response){
            let odg=JSON.parse(response);
            if(odg.greska!=""){
                $("#divOdgovor").html(odg.greska);
                return false;
            }
            window.location.assign(odg.uspeh);
        })
    }
</script>