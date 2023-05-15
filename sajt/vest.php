<?php
session_start();
require_once("_obavezni.php");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        .vest{
            border:1px solid black;
            width: 500px;
            margin:10px; 
            padding:5px;
        }
    </style>
</head>
<body>
    
    <?php
    //var_dump($_SERVER);
    //$db=konekcija();
    $db=new Baza();
    if(!$db->connect()) exit();
    statistika($db);
    echo "<a href='index.php'>Početna</a> | ";
    
    $upit="SELECT * FROM kategorije";
    $rez=$db->query($upit);
    while($red=$db->fetch_assoc($rez))
        echo "<a href='index.php?kategorija={$red['id']}'>{$red['naziv']}</a> | ";
    echo "<br>";
    
    
    if(!isset($_GET['id'])){
        echo "Vest koju tražite nije dostupna";
        exit();
    }
    $upit="SELECT * FROM pogledvesti WHERE obrisan=0 AND id={$_GET['id']}";
    $rez=$db->query($upit);
    if($db->num_rows($rez)==0){
        echo "Vest koju tražite nije dostupna ili je obrisana";
        exit();
    }
    if($db->error()){
        echo "Došlo je do greške prilikom izvršavanja upita<br>";
        echo mysqli_error();
        exit();
    }
    
    
    echo "Broj odgovora iz baze: ".$db->num_rows($rez)."<hr>";


    while($red=$db->fetch_assoc($rez)){
        echo "<div class='vest'>";
        //echo "{$red['id']}:";
        echo "<div><a href='index.php?kategorija={$red['kategorija']}'>{$red['naziv']}</a></div>";
        echo "<div><h3>{$red['naslov']}</h3></div>";
        echo "<p>{$red['tekst']}</p>";
        /*$tmp=explode(" ", $red['tekst']);
        $niz=array_slice($tmp, 0, 15);
        echo "<p>".implode(" ", $niz).".......</p>";*/
        echo "<div><u><a href='index.php?autor={$red['autor']}'>{$red['ime']} {$red['prezime']}</a></u> | <i>{$red['vremeK']}</i></div>";
        echo "</div>";
    }
   
    ?>
</body>
</html>
