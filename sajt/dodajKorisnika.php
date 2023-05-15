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
                <h2>DODAVANJE KORISNIKA</h2>
                <hr>
                <form action="dodajKorisnika.php" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="ime" class="form-label">Ime</label>
                        <input type="text" class="form-control" id="ime" name="ime">
                    </div>
                    <div class="mb-3">
                        <label for="prezime" class="form-label">Prezime</label>
                        <input type="text" class="form-control" id="prezime" name="prezime">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    <select class="form-select" aria-label="Default select example" name="status">
                        <option value="0" selected>--Izaberite status--</option>
                        <option value="Administrator">Administrator</option>
                        <option value="Urednik">Urednik</option>
                        <option value="Korisnik">Korisnik</option>
                    </select><br>
                    <div class="mb-3">
                        <label for="avatar" class="form-label">Izaberite avatar</label>
                        <input class="form-control form-control-sm" id="avatar" name="avatar" type="file" accept="image/*">
                    </div>
                    <button type="submit" class="btn btn-primary">Snimi korisnika</button>
                </form>
                <hr>
                <?php
                    if(isset($_POST['ime']) and isset($_POST['prezime']) and isset($_POST['email']) ){
                        extract($_POST, EXTR_OVERWRITE);
                        //var_dump($_POST);
                        if($ime!="" and $prezime!="" and $email!="" and $status!="0"){
                            $lozinka="12345";
                            $upit="INSERT INTO korisnici (ime, prezime, email, lozinka, status) VALUES ('{$ime}', '{$prezime}','{$email}','{$lozinka}','{$status}')";
                            $db->query($upit);
                            if($db->error()==""){
                                echo Poruka::uspeh("Uspešno snimljeni podaci u bazu");
                                Log::upisi("logovi/".date("Y-m-d")."_korisnici.log", "Dodat korisnik: '{$ime} {$prezime}'."); 
                                if(isset($_FILES['avatar']) and $_FILES['avatar']['name']!=""){
                                    $name=$db->insert_id().".jpg";
                                    if(@move_uploaded_file($_FILES['avatar']['tmp_name'], "avatars/".$name)) echo Poruka::uspeh("Uspešno prebačen avatar na server");
                                    else echo Poruka::greska("NEUSPEŠNO prebačen avatar na server!!!");
                                }
                            }
                            else
                                echo Poruka::greska("Greska prilikom upisa podataka u bazu!!<br>".$db->error());
                        }
                        else
                            echo Poruka::greska("Svi podaci su obavezni!!!!");
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