<?php
session_start();
require_once("_obavezni.php");
//Provera da li je korisnik ulogovan
if(!login()){
    echo "<h1>Morate biti prijavljeni!!!</h1><br><a href='prijava.php'>Prijavite se</a></div>";
    exit();
}

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
                <h1>PROFIL</h1>
                <hr>
                <h3>Deaktivacija/Brisanje profila</h3>
                <button class="btn btn-secondary btn-sm" onclick="deaktiviraj()">Deaktiviraj profil</button> 
                <button class="btn btn-danger btn-sm" onclick="obrisi()">Obriši profil</button>
                <hr>
                <h3>Promena lozinke</h3>
                <div class="mb-3">
                    <label for="lozinka" class="form-label">Unesite novu lozinku</label>
                    <input type="text" class="form-control" name="lozinka" id="lozinka">
                </div>
                <div class="mb-3">
                    <label for="ponovo" class="form-label">Unesite ponovo lozinku</label>
                    <input type="text" class="form-control" name="ponovo" id="ponovo">
                </div>
                <button class="btn btn-primary btn-sm" onclick="promenaLozinke()">Promeni lozinku</button>
                <hr>
                <h3>Promena podataka</h3>
                <div class="slikaOkvir">
                    <img src="avatars/_noavatar.jpg" id="imgAvatar" alt="" height="100px">
                </div>
                <form action="" method="post" enctype="multipart/form-data" id="forma">
                    <div class="mb-3">
                        <label for="ime" class="form-label">Promenite ime</label>
                        <input type="text" class="form-control" name="ime" id="ime">
                    </div>
                    <div class="mb-3">
                        <label for="prezime" class="form-label">Promenite prezime</label>
                        <input type="text" class="form-control" name="prezime" id="prezime">
                    </div>
                    <div class="mb-3">
                        <label for="avatar" class="form-label">Izaberite avatar</label>
                        <input class="form-control" type="file" id="avatar" name="avatar" accept="image/*">
                    </div>
                    <button type="button" class="btn btn-primary btn-sm mb-3" onclick="promenaPodataka()">Snimi promene</button>
                </form> 
            </div>
            <!--DESNI MENI-->
            <?php require_once("_desnimeni.php");?>
        </div>

        <!--FUTER-->
        <?php require_once("_footer.php");?>

    </div>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
<script>
    $(function(){
        prikaziKorisnika();
    })
    function deaktiviraj(){
        if(!confirm("Da li si siguran?")) return false;
        $.get("ajax/ajax_profil.php?akcija=deaktiviraj", function(response){
            let odg=JSON.parse(response);
            console.log(odg);
            if(odg.greska!=""){
                alert("Došlo je do greške!!!!\n"+odg.greska);
                return false;
            }
            window.location.assign(odg.uspeh);

        })
    }

    function obrisi(){
        if(!confirm("Da li si siguran?")) return false;
        $.get("ajax/ajax_profil.php?akcija=obrisi", function(response){
            let odg=JSON.parse(response);
            console.log(odg);
            if(odg.greska!=""){
                alert("Došlo je do greške!!!!\n"+odg.greska);
                return false;
            }
            window.location.assign(odg.uspeh);

        })
    }
    function prikaziKorisnika(){
        $.get("ajax/ajax_profil.php?akcija=prikaziKorisnika", function(response){
            console.log(response);
            let odg=JSON.parse(response);
            $("#ime").val(odg.ime);
            $("#prezime").val(odg.prezime);
            //$(".slikaOkvir").html("").append("<img src='"+odg.slika+"' width='100px' alt=''>");

            $("#imgAvatar").attr("src", "avatars/_noavatar.jpg").attr("src", odg.slika);
        })
    }

    function promenaLozinke(){
        let lozinka=$("#lozinka").val();
        let ponovo=$("#ponovo").val();
        if(lozinka=="" || ponovo==""){
            alert("Niste uneli sve podatke!!!!");
            return false;
        }

        if(lozinka!=ponovo){
            alert("Lozinke nisu iste!!!!");
            return false;
        }
        $.post("ajax/ajax_profil.php?akcija=promenaLozinke", {lozinka: lozinka, ponovo: ponovo}, function(response){
            let odg=JSON.parse(response);
            console.log(odg);
            if(odg.greska!=""){
                alert("GREŠKA!!!!\n"+odg.greska);
                return false;
            }
            alert("Bravo, care!!!!!");
            $("#lozinka").val("");
            $("#ponovo").val("");
        })
    }

    function promenaPodataka(){
        $.ajax({
            url:"ajax/ajax_profil.php?akcija=promenaPodataka",
            type:"POST",
            data: new FormData(document.getElementById("forma")),
            contentType: false,
            cache: false,
            processData: false,
            success:function(response){
                let odg=JSON.parse(response);
                console.log(odg); 
                if(odg.greska!=""){
                    alert("GREŠKA!!!\n"+odg.greska);
                    return false;
                }
                $("#spanPodaci").html($("#ime").val()+ " " +$("#prezime").val()); 
                prikaziKorisnika();
            }
        })
    }
</script>