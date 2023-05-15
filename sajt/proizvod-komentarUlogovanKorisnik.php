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
    <link href="css/lightbox.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="js/lightbox-plus-jquery.js"></script>
    <title>Document</title>
    <style>
        .slikeMale{
            display:inline-block;
            margin:5px;
            border: 1px solid black;
        }
    </style>
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
            <?php
            
            
            
            if(isset($_GET['id'])){
                $id=$_GET['id'];
                if(filter_var($id, FILTER_VALIDATE_INT)){
                    $upit="SELECT * FROM pogledproizvodi WHERE obrisan=0 AND id={$_GET['id']}";
                    $rez=$db->query($upit);
                    if($db->error()==""){
                        if($db->num_rows($rez)>0){
                            echo "Broj odgovora iz baze: ".$db->num_rows($rez)."<hr>";
                            while($red=$db->fetch_assoc($rez)){
                                echo "<div class='vest'>";
                                echo "<div><a href='index.php?kategorija={$red['kategorija']}'>{$red['naziv']}</a></div>";
                                echo "<div><h3>{$red['naslov']}</h3></div>";
                                echo "<p>".nl2br($red['tekst'])."</p>";
                                echo "<div><u><a href='index.php?autor={$red['autor']}'>{$red['ime']} {$red['prezime']}</a></u> | <i>{$red['vremeK']}</i></div>";
                                echo "</div><hr>";

                                echo "<div class='slike'>";
                                $upit="SELECT * FROM slikeproizvoda WHERE idProizvoda={$_GET['id']}";
                                //echo $upit;
                                $rez=$db->query($upit);
                                while($red=$db->fetch_object($rez)){
                                    //echo "<div class='slikeMale'><img src='slikeProizvoda/{$red->imeSlike}' height='200px'></div>";
                                    echo "<div class='slikeMale'><a href='slikeProizvoda/{$red->imeSlike}' data-lightbox='roadtrip'><img src='slikeProizvoda/{$red->imeSlike}' height='100px'></a></div>";
                                }
                                echo "</div>";
                            }
                        }
                        else
                            echo Poruka::greska("Proizvod koju tražite nije dostupan ili je obrisan");
                    }
                    else
                        echo "Došlo je do greške prilikom izvršavanja upita<br>".$db->error();
                }else{
                    echo Poruka::greska("Neovlašćen pristup ");
                    Log::upisi("logovi/".date("Y-m-d")."_greske.log", "id: {$id}, ip adresa: {$_SERVER['REMOTE_ADDR']}");
                }
                    
           
            }
            else
                echo Poruka::greska("Proizvod koju tražite nije dostupan");
            ?>
            <hr>
            <div class="row">
                <div class="col-12">
                    <h3>Komentari</h3>
                    <?php
                    if(login()){
                    ?>
                    <form action="proizvod.php?id=<?= $id?>" method="post">
                        <input type="text" name="ime" placeholder="Unesite ime" value="<?= $_SESSION['podaci']?>" required><br><br>
                        <textarea name="komentar" cols="30" rows="5" placeholder="Unesite komentar" required></textarea><br><br>
                        <button class="btn btn-primary mb-3">Snimite komentar</button>
                    </form>
                    <?php
                    }
                    ?>
                </div>
                <hr>
                <?php
                    if(isset($_GET['id'])){
                        $id=$_GET['id'];
                        //Snimanje komentara u bazu
                        if(isset($_POST['ime']) and isset($_POST['komentar'])){
                            $ime=$_POST['ime'];
                            $komentar=$_POST['komentar'];
                            $ime=filter_var($ime, FILTER_SANITIZE_STRING);
                            $komentar=filter_var($komentar, FILTER_SANITIZE_STRING);
                            if($ime!="" and $komentar!=""){
                                $upit="INSERT INTO komentari (idProizvoda, ime, komentar) VALUES ({$id}, '{$ime}', '{$komentar}')";
                                $db->query($upit);
                                if($db->error())echo Poruka::greska("Došlo je do greške!!!<br>".$db->error());
                                else echo Poruka::uspeh("Uspešno snimljen komentar");
                            }else{
                                echo Poruka::greska("Svi podaci su obavezni");
                            }
                        }
                        //Prikaz komentara na stranici
                        $upit="SELECT * FROM komentari WHERE idProizvoda={$id} ORDER BY id DESC";
                        $rez=$db->query($upit);
                        if($db->num_rows($rez)==0){
                            echo "<div class='divKomentar'>";
                            echo "<i>Nema komentara. Budite prvi</i>";
                            echo "</div><br><br>";
                        }
                        while($red=$db->fetch_object($rez)){
                            echo "<div class='divKomentar'>";
                            echo "<i>{$red->vreme}</i> - <b>{$red->ime}</b><br><p>{$red->komentar}</p>";
                            echo "</div><br><br>";
                        }
                    }
                ?>
            </div>
            
            </div>
            
            <!--DESNI MENI-->
            <?php require_once("_desnimeni.php");?>
        </div>

        <!--FUTER-->
        <?php require_once("_footer.php");?>

    </div>
</body>
</html>