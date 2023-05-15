<?php
session_start();
require_once("_obavezni.php");
//Provera da li je korisnik ulogovan
if(!login()){
    echo "<h1>Morate biti prijavljeni!!!</h1><br><a href='prijava.php'>Prijavite se</a></div>";
    exit();
}
//Provera da li je korisnik ulogovan kao Administrator
if($_SESSION['status']!="Administrator"){
    echo "<h1>Morate biti prijavljeni kao Administrator!!!</h1><br><a href='prijava.php'>Prijavite se</a></div>";
    exit();
}

//$db=konekcija();
$db=new Baza();
if(!$db->connect()) exit();
$poruka="";
if(isset($_GET['akcija']) and isset($_GET['id'])){
    $akcija=$_GET['akcija'];
    $id=$_GET['id'];
    if($akcija=="odobri")$upit="UPDATE komentari SET odobren=1 WHERE id={$id}";
    else $upit="DELETE FROM komentari WHERE id={$id}";
    $db->query($upit);
}
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
                <h2>KOMENTARI</h2>
                <hr>
                <?php
                    $upit="SELECT * FROM komentari WHERE odobren=0";
                    $rez=$db->query($upit);
                    if($db->num_rows($rez)==0){
                        echo Poruka::uspeh("Svi komentari odobreni");
                    }else{
                        while($red=$db->fetch_object($rez)){
                            echo "<div class='divKomentar'>";
                            echo "<i>{$red->vreme}</i> - <b>{$red->ime}</b><br><p>{$red->komentar}</p>";
                            echo "<a href='komentari.php?akcija=odobri&id={$red->id}'>Odobri komentar</a> | <a href='komentari.php?akcija=obrisi&id={$red->id}'>Obriši komentar</a>"; 
                            echo "</div>";
                        }
                    }
                ?>
                <hr>
                <?php
                    
                ?>
                <div class="alert alert-success"><?= $poruka?></div>
                
            </div>
            <!--DESNI MENI-->
            <?php require_once("_desnimeni.php");?>
        </div>

        <!--FUTER-->
        <?php require_once("_footer.php");?>

    </div>
</body>
</html>