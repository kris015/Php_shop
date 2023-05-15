<?php
session_start();
require_once("_obavezni.php");
//$db=konekcija();
$db=new Baza();
if(!$db->connect()) exit();
statistika($db);
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
            <form action="index.php" method="post">
                <input type="text" name="termin" placeholder="Unesite termin pretrage"> 
                <button>Pretraži</button>
            </form>
            <br>
            <?php
            
            
            
            $upit="SELECT * FROM pogledproizvodi WHERE obrisan=0 ORDER BY id DESC";
            if(isset($_GET['kategorija']))$upit="SELECT * FROM pogledproizvodi WHERE obrisan=0 AND kategorija='{$_GET['kategorija']}' ORDER BY id DESC";
            if(isset($_GET['autor']))$upit="SELECT * FROM pogledproizvodi WHERE obrisan=0 AND autor='{$_GET['autor']}' ORDER BY id DESC";
            if(isset($_POST['termin']))$upit="SELECT * FROM pogledproizvodi WHERE obrisan=0 AND (naslov LIKE('%{$_POST['termin']}%') OR tekst LIKE('%{$_POST['termin']}%')) ORDER BY id DESC";
            $rez=$db->query($upit);
            if($db->error()){
                echo "Došlo je do greške prilikom izvršavanja upita<br>";
                echo $db->error();
                exit();
            }
            
            
            echo "Broj odgovora iz baze: ".$db->num_rows($rez)."<hr>";


            while($red=$db->fetch_assoc($rez)){
                echo "<div class='vest'>";
                //echo "{$red['id']}:";
                echo "<div><a href='index.php?kategorija={$red['kategorija']}'>{$red['naziv']}</a></div>";
                echo "<div><h3><a href='proizvod.php?id={$red['id']}'>{$red['naslov']}</a></h3></div>";
                //echo "<p>{$red['tekst']}</p>";
                $tmp=explode(" ", $red['tekst']);
                $niz=array_slice($tmp, 0, 15);
                echo "<p>".nl2br(implode(" ", $niz)).".......</p>";
                $slika=(file_exists("avatars/".$red['autor'].".jpg"))?$red['autor'].".jpg":"_noavatar.jpg";
                echo "<div><img src='avatars/{$slika}' height='30px'> <u><a href='index.php?autor={$red['autor']}'>{$red['ime']} {$red['prezime']}</a></u> | <i>{$red['vremeK']}</i></div>";
                //broj komentara
                $upit="SELECT count(id) AS broj FROM komentari WHERE idProizvoda={$red['id']} AND odobren=1";
                //echo $upit;
                $pomrez=$db->query($upit);
                $pomred=$db->fetch_object($pomrez);
                echo "Komentara: {$pomred->broj}, Pogledan: {$red['pogledan']}";

                echo "</div>";
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