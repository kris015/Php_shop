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
                <h2>POSTAVLJENA PITANJA</h2>
                <hr>
                <h4>NEODGOVORENA PITANJA</h4>
                <?php
                    $upit="SELECT * FROM kontakt WHERE idKorisnika={$_SESSION['id']} AND odgovor IS NULL";
                    $rez=$db->query($upit);
                    if($db->num_rows($rez)==0) echo Poruka::info("Nema neodgovorenih pitanja");
                    else{
                        while($red=$db->fetch_object($rez)){
                            echo "<div class='divKomentar'>";
                            echo "<i>{$red->vremeP}</i><br><b>{$red->email}</b><br><p>{$red->pitanje}</p>";
                            echo "</div>";
                        }
                    }
                ?>
                <hr>
                <h4>ODGOVORENA PITANJA</h4>
                <?php
                $upit="SELECT * FROM kontakt WHERE idKorisnika={$_SESSION['id']} AND odgovor IS NOT NULL;";
                $rez=$db->query($upit);
                if($db->num_rows($rez)==0) echo Poruka::info("Nema odgovorenih pitanja");
                else{
                    while($red=$db->fetch_object($rez)){
                        echo "<div class='divKomentar'>";
                        echo "<i>{$red->vremeP}</i><br><b>{$red->email}</b><br><p>{$red->pitanje}</p>";
                        echo "<i>{$red->vremeO}</i><br><p>{$red->odgovor}</p>";
                        echo "</div>";
                    }
                }
                ?>
            </div>
            <!--DESNI MENI-->
            <?php require_once("_desnimeni.php");?>
        </div>

        <!--FUTER-->
        <?php require_once("_footer.php");?>

    </div>
</body>
</html>