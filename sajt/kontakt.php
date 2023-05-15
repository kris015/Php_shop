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
                <h1>KONTAKT</h1>
                <form action="kontakt.php" method="post">
                    <input type="email" name="email" value="<?= login()?$_SESSION['email']:""?>" placeholder="Unesite email" required><br><br>
                    <textarea name="pitanje" cols="30" rows="5" placeholder="Unesite pitanje" required></textarea><br><br>
                    <button class="btn btn-primary">Postavite pitanje</button>
                </form>
                <hr>
                <?php
                    if(isset($_POST['email'])and isset($_POST['pitanje'])){
                        $email=$_POST['email'];
                        $pitanje=$_POST['pitanje'];
                        if($email!="" and $pitanje!=""){
                            if(login())$upit="INSERT INTO kontakt (idKorisnika, email, pitanje) VALUES ({$_SESSION['id']}, '{$email}', '{$pitanje}')";
                            else $upit="INSERT INTO kontakt (email, pitanje) VALUES ('{$email}', '{$pitanje}')";
                            $db->query($upit);
                            if($db->error())echo Poruka::greska("Greška!!!<br>".$db->error());
                            else echo Poruka::uspeh("Pitanje uspešno postavljeno.<br>Odgovor će stići na mejl.");
                        }else{
                            echo Poruka::greska("Svi podaci su obavezni");
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