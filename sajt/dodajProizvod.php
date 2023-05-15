<?php
session_start();
require_once("_obavezni.php");
//Provera da li je korisnik ulogovan
if(!login()){
    echo "<h1>Morate biti prijavljeni!!!</h1><br><a href='prijava.php'>Prijavite se</a></div>";
    exit();
}
//Provera da li je korisnik ulogovan kao Administrator
if($_SESSION['status']!="Administrator" AND $_SESSION['status']!="Urednik"){
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
                <h2>DODAVANJE PROIZVODA</h2>
                <hr>
                <form action="dodajProizvod.php" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="naslov" class="form-label">Naslov</label>
                        <input type="text" class="form-control" id="naslov" name="naslov">
                    </div>
                    <div class="mb-3">
                        <label for="tekst" class="form-label">Tekst</label>
                        <textarea class="form-control" name="tekst" rows="3"></textarea>
                    </div>
                    <select class="form-select" aria-label="Default select example" name="kategorija">
                        <option value="0" selected>--Izaberite status--</option>
                        <?php
                            $upit="SELECT * FROM kategorije";
                            $rez=$db->query($upit);
                            while($red=$db->fetch_object($rez))
                                echo "<option value='{$red->id}'>{$red->naziv}</option>";
                        ?>
                    </select><br>
                    <div class="mb-3">
                        <label for="cena" class="form-label">Cena</label>
                        <input type="number" value="0" class="form-control" id="cena" name="cena">
                    </div>
                    <div class="mb-3">
                        <label for="slike" class="form-label">Izaberite slike</label>
                        <input class="form-control form-control-sm" id="slike" name="slike[]" type="file" accept="image/*" multiple>
                    </div>
                    <button type="submit" class="btn btn-primary">Snimi proizvod</button>
                </form>
                <hr>
                <?php
                    if(isset($_POST['naslov']) and isset($_POST['tekst']) and isset($_POST['kategorija']) and isset($_POST['cena'])){
                        extract($_POST, EXTR_OVERWRITE);
                        //var_dump($_POST);
                        if($naslov!="" and $tekst!="" and $kategorija!="0" and $cena!="0"){
                            $upit="INSERT INTO proizvodi (naslov, tekst, kategorija, autor, cena) VALUES('{$naslov}','{$tekst}',{$kategorija},{$_SESSION['id']},{$cena})";
                            $db->query($upit);
                            if($db->error()==""){
                                $idProizvoda=$db->insert_id();
                                echo Poruka::uspeh("Uspešno dodat proizvod");
                                Log::upisi("logovi/".date("Y-m-d")."_proizvodi.log", "Uspešno dodat proizvod '{$naslov}'"); 
                                if($_FILES['slike']['name'][0]!=""){
                                    for($i=0;$i<count($_FILES['slike']['name']);$i++){
                                        $ime=microtime(true)."_".$_FILES['slike']['name'][$i];
                                        if(move_uploaded_file($_FILES['slike']['tmp_name'][$i], "slikeProizvoda/".$ime)){
                                            
                                            $upit="INSERT INTO slikeproizvoda (idProizvoda, imeSlike)VALUES({$idProizvoda},'{$ime}' )";
                                            $db->query($upit);
                                        }
                                    }
                                }
                            }
                            else{
                                echo Poruka::greska("Neuspelo izvršavanje upita");
                                Log::upisi("logovi/".date("Y-m-d")."_proizvodi.log", "Neuspešno izvršavanje upita. ".$db->error()); 
                            }
                                
                        }
                        else
                            echo Poruka::greska("Svi podaci su obavezni");
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