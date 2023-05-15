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
                <h2>STATISTIKA</h2>
                <hr>
                <form action="statistika.php" method="post">
                    <input type="date" name="datum" value="<?=date("Y-m-d")?>"><br><br>
                    <select name="imeDat">
                        <option value="0">--Izaberite tip statistike--</option>
                        <option value="logovanja.log">Logovanja</option>
                        <option value="korisnici.log">Korisnici</option>
                        <option value="proizvodi.log">Proizvodi</option>
                        <option value="greske.log">Greške</option>
                    </select><br><br>
                    <button class="btn btn-primary">Pogledaj statistiku</button>
                </form>
                <hr>
                <?php
                    $poruka="";
                    if(isset($_POST['datum']) and isset($_POST['imeDat'])){
                        $datum=$_POST['datum'];
                        $imeDat=$_POST['imeDat'];
                        if($datum!="" and $imeDat!="0"){
                            if(file_exists("logovi/".$datum."_".$imeDat)){
                                $poruka=file_get_contents("logovi/".$datum."_".$imeDat);
                                $poruka=filter_var($poruka, FILTER_SANITIZE_STRING);
                                $poruka=nl2br($poruka);
                            }
                            else
                                $poruka=Poruka::info("Ne postoji datoteka za dan {$datum}");
                        }
                        else
                            $poruka= Poruka::greska("Svi podaci su obavezni!!!");
                    }
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