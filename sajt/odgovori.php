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
if(isset($_POST['idPitanja']) and isset($_POST['odgovor'])){
    $idPitanja=$_POST['idPitanja'];
    $odgovor=$_POST['odgovor'];
    if($idPitanja!="0" and $odgovor!=""){
        $upit="UPDATE kontakt SET odgovor='{$odgovor}' WHERE id={$idPitanja}";
        $db->query($upit);
        //Slanje mejla
        $upit="SELECT * FROM kontakt where id={$idPitanja}";
        $rez=$db->query($upit);
        $red=$db->fetch_object($rez);
        // The message
        $message = "Odgovor na pitanje '{$red->pitanje}'<br>{$odgovor}";

        // In case any of our lines are larger than 70 characters, we should use wordwrap()
        $message = wordwrap($message, 70, "\r\n");

        // Send
        @mail("{$red->email}", "Odgovor na pitanje '{$red->pitanje}'", $message);
        echo $message;
    }

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
                <h2>NEODGOVORENA PITANJA</h2>
                <hr>
                <form action="odgovori.php" method="post">
                    <select name="idPitanja">
                        <option value="0">--Izaberite pitanje--</option>
                        <?php
                        $upit="SELECT * FROM kontakt WHERE odgovor is null;";
                        $rez=$db->query($upit);
                        while($red=$db->fetch_object($rez))
                            echo "<option value='{$red->id}'>{$red->email}: {$red->pitanje}</option>";
                        ?>
                    </select><br><br>
                    <textarea name="odgovor" cols="30" rows="5" required placeholder="Unesite odgovor"></textarea><br><br>
                    <button class="btn btn-primary">Odgovorite</button>
                </form>
                <hr>

                
                
            </div>
            <!--DESNI MENI-->
            <?php require_once("_desnimeni.php");?>
        </div>

        <!--FUTER-->
        <?php require_once("_footer.php");?>

    </div>
</body>
</html>